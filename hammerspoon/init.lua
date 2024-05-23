-- Application manipulations

local hyper = {"cmd", "alt", "ctrl", "shift"}

hs.hotkey.bind(hyper, "a", function()
    hs.application.launchOrFocus("Alacritty")
end)
hs.hotkey.bind(hyper, "z", function() -- Sometimes ² gets remapped to <...
    hs.application.launchOrFocus("Kitty")
end)
hs.hotkey.bind(hyper, "e", function() -- ctrl + 2 doesn't work anymore...
    hs.application.launchOrFocus("Arc")
end)
hs.hotkey.bind(hyper, "r", function() -- ctrl + 2 doesn't work anymore...
    hs.application.launchOrFocus("Slack")
end)
hs.hotkey.bind(hyper, "t", function()
    hs.application.launchOrFocus("zoom.us")
end)
hs.hotkey.bind(hyper, "q", function()
    hs.application.launchOrFocus("qutebrowser")
end)
hs.hotkey.bind(hyper, "o", function()
    hs.application.launchOrFocus("Obsidian")
end)
hs.hotkey.bind(hyper, "p", function()
    hs.application.launchOrFocus("1Password")
end)

-- Open new tab in Qutebrowser
hs.hotkey.bind({"alt"}, 'space', function()
    hs.application.launchOrFocus("qutebrowser")
    hs.eventtap.keyStroke({}, 'ESCAPE')
    hs.eventtap.keyStroke({"shift"}, 'o')
end)

-- Start chatgpt in Arc
hs.hotkey.bind(hyper, "g", function()
    hs.application.launchOrFocus("Arc")
    hs.eventtap.keyStroke({"cmd", "alt"}, 'g')
end)

-- Open calendar
hs.hotkey.bind(hyper, "c", function()
    hs.application.launchOrFocus("Arc")
    hs.eventtap.keyStroke({"cmd"}, '1')
end)

-- Open mail
hs.hotkey.bind(hyper, "m", function()
    hs.application.launchOrFocus("Arc")
    hs.eventtap.keyStroke({"cmd"}, '2')
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
