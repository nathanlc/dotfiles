-- Application manipulations
hs.hotkey.bind({"ctrl"}, "²", function() -- ctrl + 1 is not working for some reason
    hs.application.launchOrFocus("iTerm")
end)
hs.hotkey.bind({"ctrl"}, "<", function() -- Sometimes ² gets remapped to <...
    hs.application.launchOrFocus("iTerm")
end)
hs.hotkey.bind({"ctrl"}, "2", function() -- ctrl + 2 doesn't work anymore...
    hs.application.launchOrFocus("Vivaldi Snapshot")
end)
hs.hotkey.bind({"ctrl", "shift"}, "2", function() -- ctrl + 2 doesn't work anymore...
    hs.application.launchOrFocus("Vivaldi Snapshot")
end)
hs.hotkey.bind({"ctrl"}, "3", function()
    hs.application.launchOrFocus("Safari")
end)
hs.hotkey.bind({"ctrl"}, "4", function()
    hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind({"ctrl"}, "5", function()
    hs.application.launchOrFocus("zoom.us")
end)


-- Window manipulations
local macbook2015Screen = "Built-in Retina Display"
local workUltrawideScreen = "PHL 346E2C"
local workHomeScreen = "DELL UP2414Q"

local workLayout = {
    {"Vivaldi", nil, workUltrawideScreen, {x=0, y=0, w=0.4, h=1}, nil, nil},
    {"iTerm2", nil, workUltrawideScreen, {x=0.4, y=0, w=0.6, h=1}, nil, nil},
    {"Emacs", nil, workUltrawideScreen, {x=0.5, y=0, w=0.5, h=1}, nil, nil},
    {"Slack", nil, macbook2015Screen, hs.layout.maximized, nil, nil},
    {"Safari", nil, macbook2015Screen, hs.layout.maximized, nil, nil},
}

local workHomeLayout = {
    {"Vivaldi", nil, workHomeScreen, hs.layout.maximized, nil, nil},
    {"iTerm2", nil, workHomeScreen, hs.layout.maximized, nil, nil},
    {"Emacs", nil, workUltrawideScreen, hs.layout.maximized, nil, nil},
    {"Slack", nil, macbook2015Screen, hs.layout.maximized, nil, nil},
    {"Safari", nil, macbook2015Screen, hs.layout.maximized, nil, nil},
}

hs.window.animationDuration = 0.01
local function bindWindow(key, lambda)
    hs.hotkey.bind({"cmd", "alt"}, key, lambda)
end

bindWindow("2", function()
    hs.layout.apply(workLayout)
end)

bindWindow("3", function()
    hs.layout.apply(workHomeLayout)
end)

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


-- Start search (open new tab) in Vivaldi from anywhere
hs.hotkey.bind({"cmd", "shift"}, 'space', function()
    hs.application.launchOrFocus("Vivaldi Snapshot")
    hs.eventtap.keyStroke({"cmd"}, 'T')
end)
