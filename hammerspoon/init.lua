-- Application manipulations
-- Ctrl + 1 is not working for some reason. It worked in Quicksilver
-- hs.hotkey.bind({"ctrl"}, "1", function()
    -- hs.application.launchOrFocus("iTerm")
-- end)
hs.hotkey.bind({"ctrl"}, "²", function()
    hs.application.launchOrFocus("iTerm")
end)
hs.hotkey.bind({"ctrl"}, "2", function()
    hs.application.launchOrFocus("Vivaldi Snapshot")
end)

hs.hotkey.bind({"ctrl"}, "3", function()
    hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind({"ctrl"}, "4", function()
    hs.application.launchOrFocus("zoom.us")
end)


-- Window manipulations
hs.window.animationDuration = 0.1

hs.hotkey.bind({"cmd", "alt"}, "H", function()
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screenFrame = window:screen():frame()

    frame.x = screenFrame.x
    frame.y = screenFrame.y
    frame.w = screenFrame.w / 2
    frame.h = screenFrame.h
    window:setFrame(frame)
end)

hs.hotkey.bind({"cmd", "alt"}, "L", function()
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

hs.hotkey.bind({"cmd", "alt"}, "M", function()
    local window = hs.window.focusedWindow()

    window:maximize()
end)
