local ClamshellDetector = {}

-- Configuration
local CLAMSHELL_GAP = 40
local LAPTOP_GAP = 0
local CHECK_INTERVAL = 30 -- seconds (battery-friendly)

-- State tracking
local currentMode = nil
local screenWatcher = nil
local timerCheck = nil

-- Detect if we're in clamshell mode
function ClamshellDetector:detectClamshellMode()
	local screens = hs.screen.allScreens()
	local builtinActive = false
	local externalExists = false

	for _, screen in ipairs(screens) do
		local screenName = screen:name()
		if screenName and screenName:match("Built%-in") then
			builtinActive = true
		elseif screenName then
			externalExists = true
		end
	end

	-- Clamshell mode = builtin display off AND external display connected
	local isClamshell = not builtinActive and externalExists

	-- Debug info
	local screenInfo = {}
	for _, screen in ipairs(screens) do
		table.insert(screenInfo, screen:name() or "Unknown")
	end

	hs.printf(
		"[ClamshellDetector] Screens: %s | Builtin: %s | External: %s | Clamshell: %s",
		table.concat(screenInfo, ", "),
		tostring(builtinActive),
		tostring(externalExists),
		tostring(isClamshell)
	)

	return isClamshell
end

-- Set Rectangle screen edge gap and restart Rectangle
function ClamshellDetector:setRectangleGap(gapValue)
	local command = string.format("defaults write com.knollsoft.Rectangle screenEdgeGapTop -int %d", gapValue)
	hs.printf("[ClamshellDetector] Setting Rectangle gap to %d: %s", gapValue, command)

	local result = hs.execute(command)
	if result then
		hs.printf("[ClamshellDetector] Successfully set Rectangle gap to %d", gapValue)
		-- Restart Rectangle to apply the new settings
		self:restartRectangle()
	else
		hs.printf("[ClamshellDetector] Failed to set Rectangle gap")
	end

	return result
end

-- Restart Rectangle application to apply new settings
function ClamshellDetector:restartRectangle()
	hs.printf("[ClamshellDetector] Restarting Rectangle...")

	-- Check if Rectangle is running
	local rectangleApp = hs.application.get("Rectangle")
	if rectangleApp then
		hs.printf("[ClamshellDetector] Rectangle is running, restarting...")
		rectangleApp:kill()
		-- Wait a moment then restart
		hs.timer.doAfter(1.0, function()
			hs.application.launchOrFocus("Rectangle")
			hs.printf("[ClamshellDetector] Rectangle restarted")
		end)
	else
		hs.printf("[ClamshellDetector] Rectangle not running, launching...")
		hs.application.launchOrFocus("Rectangle")
	end
end

-- Handle mode change
function ClamshellDetector:handleModeChange(isClamshell)
	local newMode = isClamshell and "clamshell" or "laptop"

	if newMode ~= currentMode then
		currentMode = newMode

		local gapValue = isClamshell and CLAMSHELL_GAP or LAPTOP_GAP

		hs.printf("[ClamshellDetector] Mode changed to: %s", newMode)
		hs.alert.show(string.format("Mode: %s\nSetting gap: %d\nRestarting Rectangle...", newMode, gapValue))

		self:setRectangleGap(gapValue)
	end
end

-- Check current mode and update if needed
function ClamshellDetector:checkMode()
	local isClamshell = self:detectClamshellMode()
	self:handleModeChange(isClamshell)
end

-- Screen configuration changed callback
function ClamshellDetector:onScreenChanged()
	hs.printf("[ClamshellDetector] Screen configuration changed")
	-- Small delay to let system settle
	hs.timer.doAfter(0.5, function()
		self:checkMode()
	end)
end

-- Initialize the detector
function ClamshellDetector:init()
	hs.printf("[ClamshellDetector] Initializing...")

	-- Initial mode check
	self:checkMode()

	-- Watch for screen configuration changes
	screenWatcher = hs.screen.watcher.new(function()
		self:onScreenChanged()
	end)
	screenWatcher:start()

	-- Periodic check as backup (in case we miss events)
	timerCheck = hs.timer.doEvery(CHECK_INTERVAL, function()
		self:checkMode()
	end)

	hs.printf("[ClamshellDetector] Initialized successfully")
	hs.alert.show("ClamshellDetector started")
end

-- Stop the detector
function ClamshellDetector:stop()
	if screenWatcher then
		screenWatcher:stop()
		screenWatcher = nil
	end

	if timerCheck then
		timerCheck:stop()
		timerCheck = nil
	end

	hs.printf("[ClamshellDetector] Stopped")
	hs.alert.show("ClamshellDetector stopped")
end

-- Manual mode toggle for testing
function ClamshellDetector:toggleMode()
	local isClamshell = not (currentMode == "clamshell")
	hs.printf("[ClamshellDetector] Manual toggle to: %s", isClamshell and "clamshell" or "laptop")
	self:handleModeChange(isClamshell)
end

return ClamshellDetector

