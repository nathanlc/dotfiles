-- Application manipulations
hs.hotkey.bind({"ctrl"}, "²", function() -- ctrl + 1 is not working for some reason
    hs.application.launchOrFocus("iTerm")
end)
hs.hotkey.bind({"ctrl"}, "2", function()
    hs.application.launchOrFocus("Vivaldi Snapshot")
end)

hs.hotkey.bind({"ctrl"}, "3", function()
    hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({"ctrl"}, "4", function()
    hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind({"ctrl"}, "5", function()
    hs.application.launchOrFocus("zoom.us")
end)


-- Window manipulations
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

bindWindow("up", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenNorth()
end)

bindWindow("down", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenSouth()
end)

bindWindow("left", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenWest()
end)

bindWindow("right", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenEast()
end)


-- Window scrolling
local function bindScrool(key, lambda)
    hs.hotkey.bind({"ctrl", "alt"}, key, lambda)
end

bindScrool("u", function()
    local frame = hs.window.focusedWindow():frame()
    local frameCenter = {
        x = frame.x + (frame.w / 2),
        y = frame.y + (frame.h / 2)
    }
    hs.mouse.absolutePosition(frameCenter)
    hs.eventtap.scrollWheel({0, 10}, {}, "line")
end)

bindScrool("d", function()
    hs.eventtap.scrollWheel({0, -10}, {}, "line")
end)

bindScrool("p", function()
    hs.eventtap.scrollWheel({0, 1}, {}, "line")
end)

bindScrool("n", function()
    hs.eventtap.scrollWheel({0, -1}, {}, "line")
end)
