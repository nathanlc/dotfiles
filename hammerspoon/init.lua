-- Application manipulations
hs.hotkey.bind({"ctrl"}, "²", function() -- ctrl + 1 is not working for some reason
    hs.application.launchOrFocus("iTerm")
end)
hs.hotkey.bind({"ctrl"}, "<", function() -- Sometimes ² gets remapped to <...
    hs.application.launchOrFocus("iTerm")
end)
hs.hotkey.bind({"ctrl", "shift"}, "1", function() -- ctrl + 2 doesn't work anymore...
    hs.application.launchOrFocus("Warp")
end)
hs.hotkey.bind({"ctrl"}, "1", function() -- ctrl + 2 doesn't work anymore...
    hs.application.launchOrFocus("Warp")
end)
hs.hotkey.bind({"ctrl", "shift"}, "2", function() -- ctrl + 2 doesn't work anymore...
    hs.application.launchOrFocus("iTerm")
end)
hs.hotkey.bind({"ctrl"}, "2", function() -- ctrl + 2 doesn't work anymore...
    hs.application.launchOrFocus("iTerm")
end)
hs.hotkey.bind({"ctrl", "shift"}, "3", function()
    hs.application.launchOrFocus("Arc")
end)
hs.hotkey.bind({"ctrl"}, "3", function()
  hs.application.launchOrFocus("Arc")
end)
hs.hotkey.bind({"ctrl"}, "4", function()
    hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind({"ctrl"}, "5", function()
    hs.application.launchOrFocus("zoom.us")
end)


hs.window.animationDuration = 0.01
local function bindWindow(key, lambda)
    hs.hotkey.bind({"cmd", "alt"}, key, lambda)
end

bindWindow("H", function()
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screenFrame = window:screen():frame()

    frame.x = screenFrame.x
    frame.y = screenFrame.y
    frame.w = screenFrame.w / 2
    frame.h = screenFrame.h
    window:setFrame(frame)
end)

bindWindow("L", function()
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screenFrame = window:screen():frame()
    local halfScreenWidth = screenFrame.w / 2

    frame.x = screenFrame.x + halfScreenWidth
    frame.y = screenFrame.y
    frame.w = halfScreenWidth
    frame.h = screenFrame.h
    window:setFrame(frame)
end)

bindWindow("M", function()
    local window = hs.window.focusedWindow()

    window:maximize()
end)

bindWindow("i", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenNorth()
end)

bindWindow("u", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenSouth()
end)

bindWindow("y", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenWest()
end)

bindWindow("o", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenEast()
end)


-- Window scrolling
local function bindScrool(key, lambda)
    hs.hotkey.bind({"ctrl", "alt"}, key, lambda)
end

local function centerMouse()
    local frame = hs.window.focusedWindow():frame()
    local frameCenter = {
        x = frame.x + (frame.w / 2),
        y = frame.y + (frame.h / 2)
    }
    hs.mouse.absolutePosition(frameCenter)
end

bindScrool("u", function()
    centerMouse()
    hs.eventtap.scrollWheel({0, 10}, {}, "line")
end)

bindScrool("d", function()
    centerMouse()
    hs.eventtap.scrollWheel({0, -10}, {}, "line")
end)

bindScrool("k", function()
    centerMouse()
    hs.eventtap.scrollWheel({0, 1}, {}, "line")
end)

bindScrool("j", function()
    centerMouse()
    hs.eventtap.scrollWheel({0, -1}, {}, "line")
end)


-- Start Cmd-T in Arc from anywhere
hs.hotkey.bind({"alt"}, 'space', function()
    hs.application.launchOrFocus("Arc")
    hs.eventtap.keyStroke({"cmd"}, 't')
end)
