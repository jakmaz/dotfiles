-- Hammerspoon Configuration - Modular Setup
-- Load modules
local TrackpadLauncher = require("modules.trackpad-launcher")
local ClamshellDetector = require("modules.clamshell-detector")

-- Initialize modules
hs.printf("[Hammerspoon] Loading modules...")

-- Initialize clamshell detector
ClamshellDetector:init()

-- Initialize trackpad launcher (currently has issues, but module is ready)
-- TrackpadLauncher:init()

-- Global hotkeys
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "S", function()
    TrackpadLauncher:start()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Q", function()
    TrackpadLauncher:stop()
end)

-- Clamshell detector hotkeys for testing
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "C", function()
    ClamshellDetector:checkMode()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "T", function()
    ClamshellDetector:toggleMode()
end)

hs.printf("[Hammerspoon] Configuration loaded successfully!")
hs.alert.show("Hammerspoon loaded!\nClamshell detector active\nHotkeys:\nCmd+Alt+Ctrl+C: Check mode\nCmd+Alt+Ctrl+T: Toggle test")