-- Enable cli hs
require("hs.ipc")
hs.ipc.cliInstall("/opt/homebrew", false)
hs.ipc.cliSaveHistory(true)
hs.ipc.cliSaveHistorySize(5000)

-- Modals
local globalModal = hs.hotkey.modal.new('alt', 'space')
local configModal = hs.hotkey.modal.new('', nil)
local musicModal = hs.hotkey.modal.new('', nil)
local projectModal = hs.hotkey.modal.new('', nil)
local inputSourceModal = hs.hotkey.modal.new('', nil)

globalModal:bind('', 'escape', function() globalModal:exit() end)
globalModal:bind('', 'C', function()
	globalModal:exit()
	configModal:enter()
end)
globalModal:bind('', 'M', function()
	globalModal:exit()
	musicModal:enter()
end)
globalModal:bind('', 'P', function()
	globalModal:exit()
	projectModal:enter()
end)
globalModal:bind('', 'I', function()
	globalModal:exit()
	inputSourceModal:enter()
end)

configModal:bind('', 'escape', function() configModal:exit() end)
configModal:bind('', 'R', function()
	hs.reload()
end)

musicModal:bind('', 'escape', function() musicModal:exit() end)
musicModal:bind('', 'space', function()
	hs.spotify.playpause()
	musicModal:exit()
end)
musicModal:bind('', 'N', function()
	hs.spotify.next()
	musicModal:exit()
end)
musicModal:bind('', 'P', function()
	hs.spotify.previous()
	musicModal:exit()
end)
musicModal:bind('', 'O', function()
	hs.spotify.displayCurrentTrack()
	musicModal:exit()
end)

local function setLayout(layout)
	hs.keycodes.setLayout(layout)
	hs.alert.show(layout)
end

inputSourceModal:bind('', 'escape', function() inputSourceModal:exit() end)
inputSourceModal:bind('', 'U', function()
	setLayout("U.S.")
	inputSourceModal:exit()
end)
inputSourceModal:bind('', 'F', function()
	setLayout("French – PC")
	inputSourceModal:exit()
end)
inputSourceModal:bind('', 'S', function()
	setLayout("Swedish")
	inputSourceModal:exit()
end)

---@class Project
---@field jira string?
---@field repo string?
---@field branch string?
---@field prNumber string?

---@return Project
local function newProject()
	return {
		jira = nil,
		repo = nil,
		branch = nil,
		prNumber = nil,
	}
end

---@param project Project
---@return string
local function projectToString(project)
	return "Project\n" ..
		"Jira: " .. (project.jira or "nil") .. "\n" ..
		"Repo: " .. (project.repo or "nil") .. "\n" ..
		"Branch: " .. (project.branch or "nil") .. "\n" ..
		"PR: " .. (project.prNumber or "nil")
end

local project = newProject()
projectModal:bind('', 'escape', function() projectModal:exit() end)
projectModal:bind('', 'S', function()
	project = newProject()

	local frontApp = hs.application.frontmostApplication()
	local appName = frontApp:name()
	if appName == "Arc" then
		-- Save current clipboard to restore after getting the current URL in Arc.
		local currentlyPasted = hs.pasteboard.getContents()
		hs.eventtap.keyStroke({"cmd", "shift"}, 'C')
		local url = hs.pasteboard.getContents()
		hs.pasteboard.setContents(currentlyPasted)

		local jiraTicket = url:match("https://glooko.atlassian.net/browse/([A-Za-z][A-Za-z][A-Za-z][A-Za-z]?%-%d%d%d%d?%d?)")
		local org, repo, prNumber = url:match("https://github%.com/([^/]+)/([^/]+)/pull/(%d+)")
		if jiraTicket then
			project.jira = jiraTicket
		end
		if org and repo and prNumber then
			project.repo = org .. "/" .. repo
			project.prNumber = prNumber
		end

		hs.alert.show("Project: " .. projectToString(project))
	-- elseif appName == "kitty" then
	end

	projectModal:exit()
end)

-- -- Application manipulations
-- local hyper = {"cmd", "alt", "ctrl", "shift"}
--
-- hs.hotkey.bind(hyper, "a", function()
--     hs.application.launchOrFocus("Alacritty")
-- end)
-- hs.hotkey.bind(hyper, "z", function()
--     hs.application.launchOrFocus("Kitty")
-- end)
-- hs.hotkey.bind(hyper, "e", function()
--     hs.application.launchOrFocus("Arc")
-- end)
-- hs.hotkey.bind(hyper, "r", function()
--     hs.application.launchOrFocus("Slack")
-- end)
-- hs.hotkey.bind(hyper, "t", function()
--     hs.application.launchOrFocus("zoom.us")
-- end)
-- hs.hotkey.bind(hyper, "q", function()
--     hs.application.launchOrFocus("qutebrowser")
-- end)
-- hs.hotkey.bind(hyper, "o", function()
--     hs.application.launchOrFocus("Obsidian")
-- end)
-- hs.hotkey.bind(hyper, "p", function()
--     hs.application.launchOrFocus("1Password")
-- end)
-- hs.hotkey.bind(hyper, "s", function()
--     hs.application.launchOrFocus("Spotify")
-- end)
--
-- -- Open new tab in Qutebrowser
-- hs.hotkey.bind({"alt"}, 'space', function()
--     hs.application.launchOrFocus("qutebrowser")
--     hs.eventtap.keyStroke({}, 'ESCAPE')
--     hs.eventtap.keyStroke({"shift"}, 'o')
-- end)
--
-- -- Start chatgpt in Arc
-- hs.hotkey.bind(hyper, "g", function()
--     hs.application.launchOrFocus("Arc")
--     hs.eventtap.keyStroke({"cmd", "alt"}, 'g')
-- end)
--
-- ---Type a key with mods after a set delay
-- ---@param mods table
-- ---@param key string
-- local type_delay = function(mods, key)
--     hs.timer.doAfter(
--         0.1,
--         hs.eventtap.keyStroke(mods, key)
--     )
-- end
--
-- -- Open calendar
-- hs.hotkey.bind(hyper, "c", function()
--     hs.application.launchOrFocus("Arc")
--     type_delay({"cmd"}, '1')
-- end)
--
-- -- Open mail
-- hs.hotkey.bind(hyper, "m", function()
--     hs.application.launchOrFocus("Arc")
--     type_delay({"cmd"}, '2')
-- end)
--
-- hs.window.animationDuration = 0.01
-- local function bindWindow(key, lambda)
--     hs.hotkey.bind({"cmd", "alt"}, key, lambda)
-- end
--
-- function WindowRight()
--     local window = hs.window.focusedWindow()
--     local frame = window:frame()
--     local screenFrame = window:screen():frame()
--     local halfScreenWidth = screenFrame.w / 2
--
--     frame.x = screenFrame.x + halfScreenWidth
--     frame.y = screenFrame.y
--     frame.w = halfScreenWidth
--     frame.h = screenFrame.h
--     window:setFrame(frame)
-- end
--
-- function WindowLeft()
--     local window = hs.window.focusedWindow()
--     local frame = window:frame()
--     local screenFrame = window:screen():frame()
--
--     frame.x = screenFrame.x
--     frame.y = screenFrame.y
--     frame.w = screenFrame.w / 2
--     frame.h = screenFrame.h
--     window:setFrame(frame)
-- end
--
-- function WindowMaximize()
--     local window = hs.window.focusedWindow()
--     window:maximize()
-- end
--
-- bindWindow("H", WindowLeft)
-- bindWindow("L", WindowRight)
-- bindWindow("M", WindowMaximize)
--
-- bindWindow("i", function()
--     local window = hs.window.focusedWindow()
--     window:moveOneScreenNorth()
-- end)
--
-- bindWindow("u", function()
--     local window = hs.window.focusedWindow()
--     window:moveOneScreenSouth()
-- end)
--
-- bindWindow("y", function()
--     local window = hs.window.focusedWindow()
--     window:moveOneScreenWest()
-- end)
--
-- bindWindow("o", function()
--     local window = hs.window.focusedWindow()
--     window:moveOneScreenEast()
-- end)
--
--
-- -- Window scrolling
-- local function bindScrool(key, lambda)
--     hs.hotkey.bind({"ctrl", "alt"}, key, lambda)
-- end
--
-- local function centerMouse()
--     local frame = hs.window.focusedWindow():frame()
--     local frameCenter = {
--         x = frame.x + (frame.w / 2),
--         y = frame.y + (frame.h / 2)
--     }
--     hs.mouse.absolutePosition(frameCenter)
-- end
--
-- bindScrool("u", function()
--     centerMouse()
--     hs.eventtap.scrollWheel({0, 10}, {}, "line")
-- end)
--
-- bindScrool("d", function()
--     centerMouse()
--     hs.eventtap.scrollWheel({0, -10}, {}, "line")
-- end)
--
-- bindScrool("k", function()
--     centerMouse()
--     hs.eventtap.scrollWheel({0, 1}, {}, "line")
-- end)
--
-- bindScrool("j", function()
--     centerMouse()
--     hs.eventtap.scrollWheel({0, -1}, {}, "line")
-- end)
