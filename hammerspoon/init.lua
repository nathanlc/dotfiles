hs.hotkey.bind({"cmd", "alt", "ctrl"}, "w", function()
  -- hs.alert.show("Hello World!")
    hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)

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
    local frame = window:frame()
    local screenFrame = window:screen():frame()

    frame.x = screenFrame.x
    frame.y = screenFrame.y
    frame.w = screenFrame.w
    frame.h = screenFrame.h
    window:setFrame(frame)
end)
