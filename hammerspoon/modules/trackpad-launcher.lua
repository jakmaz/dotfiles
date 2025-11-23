local TrackpadLauncher = {}

-- Configuration
local gesture = hs.eventtap.event.types.gesture
local trackpadWatcher = nil

-- Define top-right corner zone (normalized coordinates 0.0-1.0)
local TOP_RIGHT_ZONE = {
    x1 = 0.75,  -- Right 25% of trackpad
    x2 = 1.0,   -- Full right edge
    y1 = 0.0,   -- Top edge
    y2 = 0.33   -- Top third of trackpad
}

local function isInTopRightCorner(x, y)
    return x >= TOP_RIGHT_ZONE.x1 and x <= TOP_RIGHT_ZONE.x2 and
           y >= TOP_RIGHT_ZONE.y1 and y <= TOP_RIGHT_ZONE.y2
end

-- Start trackpad touch monitoring
function TrackpadLauncher:start()
    if trackpadWatcher then
        self:stop()
    end
    
    trackpadWatcher = hs.eventtap.new({ gesture }, function(event)
        local eventType = event:getType(true)
        if eventType ~= gesture then
            return
        end

        local touches = event:getTouches()
        if #touches ~= 1 then
            return
        end -- Only single finger touches

        local touch = touches[1]
        -- Check for initial touch (began phase)
        if touch.phase == "began" then
            local x = touch.normalizedPosition.x
            local y = touch.normalizedPosition.y

            hs.printf("[TrackpadLauncher] Touch detected at: %.2f, %.2f", x, y)

            if isInTopRightCorner(x, y) then
                hs.alert.show("🎯 Top-Right Corner Touched!\nPosition: " ..
                             string.format("%.2f, %.2f", x, y))
                return true -- Consume the event
            end
        end

        return false -- Let other events pass through
    end)

    trackpadWatcher:start()
    hs.printf("[TrackpadLauncher] Started")
    hs.alert.show("TrackpadLauncher started! Touch top-right corner to test.")
end

-- Stop trackpad monitoring
function TrackpadLauncher:stop()
    if trackpadWatcher then
        trackpadWatcher:stop()
        trackpadWatcher = nil
        hs.printf("[TrackpadLauncher] Stopped")
        hs.alert.show("TrackpadLauncher stopped.")
    end
end

-- Initialize the launcher
function TrackpadLauncher:init()
    hs.printf("[TrackpadLauncher] Initializing...")
    self:start()
end

return TrackpadLauncher