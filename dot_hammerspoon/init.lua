-- hs.loadSpoon("SpoonInstall")
--
-- spoon.SpoonInstall.repos.PaperWM = {
-- 	url = "https://github.com/mogenson/PaperWM.spoon",
-- 	desc = "PaperWM.spoon repository",
-- 	branch = "release",
-- }
--

ActiveSpace = hs.loadSpoon("ActiveSpace")
ActiveSpace.compact = true
ActiveSpace:start()

PaperWM = hs.loadSpoon("PaperWM")
local spaces = require("hs.spaces")

-- App placement rules:
--   space = target workspace
--   position = column position (1 = leftmost)
--   width = width ratio (e.g., 1/3, 1/2, 2/3)
local appPlacement = {
	["Messages"] = { space = 3, position = 1, width = 1 / 2 },
	["Discord"] = { space = 3, position = 2, width = 1 / 2 },
	["Microsoft Teams"] = { space = 4, position = 1, width = 2 / 3 },
	["Slack"] = { space = 4, position = 2, width = 2 / 3 },
	["Microsoft Outlook"] = { space = 4, position = 3, width = 2 / 3 },
}

-- Auto-center mode: automatically center the focused window
local autoCenterMode = false

-- Create a separate window filter for auto-center (to avoid conflicts)
local autoCenterFilter = hs.window.filter.new(nil)
autoCenterFilter:subscribe(hs.window.filter.windowFocused, function(win, appName)
	if autoCenterMode and win then
		-- Small delay to let PaperWM's own focus handling complete first
		hs.timer.doAfter(0.2, function()
			-- Only center if window is managed by PaperWM (not floating)
			if not PaperWM.floating.isFloating(win) and PaperWM.state.windowIndex(win) then
				PaperWM.windows.centerWindow()
			end
		end)
	end
end)

-- Toggle auto-center mode
local function toggleAutoCenterMode()
	autoCenterMode = not autoCenterMode
	if autoCenterMode then
		hs.alert.show("Auto-Center Mode: ON")
		-- Center the current window immediately
		PaperWM.windows.centerWindow()
	else
		hs.alert.show("Auto-Center Mode: OFF")
	end
end

-- Bind toggle to hotkey (alt + ctrl + c)
hs.hotkey.bind({ "alt", "ctrl" }, "c", toggleAutoCenterMode)

-- Ensure the required number of spaces exist on the main screen
local function ensureSpacesExist(requiredSpaceIndex)
	local screen = hs.screen.mainScreen()
	local screenUUID = screen:getUUID()
	local allSpaces = hs.spaces.allSpaces()
	local currentSpaces = allSpaces[screenUUID] or {}
	local currentCount = #currentSpaces

	if currentCount >= requiredSpaceIndex then
		return true -- Already have enough spaces
	end

	local spacesToCreate = requiredSpaceIndex - currentCount
	print("Creating " .. spacesToCreate .. " new space(s) to reach space " .. requiredSpaceIndex)

	for i = 1, spacesToCreate do
		hs.spaces.addSpaceToScreen(screen, false)
		-- Small delay to let the space be created
		hs.timer.usleep(300000) -- 0.3 seconds
	end

	return true
end

-- Resize a window to a specific width ratio
local function resizeWindow(win, widthRatio)
	local screen = win:screen()
	if not screen then
		return
	end

	local canvas = PaperWM.windows.getCanvas(screen)
	local frame = win:frame()

	-- Calculate new width based on ratio, accounting for gaps
	local gap = PaperWM.windows.getGap("left") + PaperWM.windows.getGap("right")
	local newWidth = widthRatio * (canvas.w + gap) - gap

	frame.w = newWidth
	PaperWM.windows.moveWindow(win, frame)

	-- Re-tile the space
	local spaceID = hs.spaces.windowSpaces(win)[1]
	if spaceID then
		PaperWM:tileSpace(spaceID)
	end
end

-- Move a specific window to a space (works across spaces, unlike PaperWM.space.moveWindowToSpace)
local function moveWindowToSpace(win, spaceIndex)
	if not win then
		return false
	end

	-- Create spaces if they don't exist
	ensureSpacesExist(spaceIndex)

	local newSpace = PaperWM.space.MissionControl:getSpaceID(spaceIndex)
	if not newSpace then
		print("Space not found: " .. spaceIndex)
		return false
	end

	local currentSpace = hs.spaces.windowSpaces(win)[1]
	if newSpace == currentSpace then
		print("Window already on target space")
		return true
	end

	if hs.spaces.spaceType(newSpace) ~= "user" then
		print("Invalid space type")
		return false
	end

	-- First, switch to the space where the window currently is
	-- (Mission Control can only see windows on the current space)
	hs.spaces.gotoSpace(currentSpace)

	-- Small delay to let the space switch complete
	hs.timer.usleep(500000) -- 0.5 seconds

	-- Focus the window
	win:focus()

	-- Another small delay
	hs.timer.usleep(200000) -- 0.2 seconds

	-- Toggle to floating before moving (required by PaperWM)
	if not PaperWM.floating.isFloating(win) then
		PaperWM.floating.toggleFloating(win)
	end

	-- Use MissionControl to move the specific window
	local ret, err = PaperWM.space.MissionControl:moveWindowToSpace(win, newSpace)
	if not ret or err then
		print("Error moving window: " .. (err or "unknown"))
		-- Toggle floating back if move failed
		if PaperWM.floating.isFloating(win) then
			PaperWM.floating.toggleFloating(win)
		end
		return false
	end

	-- Wait for the window to appear on the new space, then toggle floating off
	local checkCount = 0
	hs.timer.doUntil(function()
		checkCount = checkCount + 1
		return hs.spaces.windowSpaces(win)[1] == newSpace or checkCount > 20
	end, function()
		if hs.spaces.windowSpaces(win)[1] == newSpace then
			PaperWM.floating.toggleFloating(win)
			PaperWM.space.MissionControl:focusSpace(newSpace, win)
		end
	end, 0.1)

	return true
end

-- Reposition a window to a specific column position within its space
local function repositionWindow(win, targetPosition)
	local index = PaperWM.state.windowIndex(win)
	if not index then
		return
	end

	local spaceID = index.space
	local currentCol = index.col
	local columns = PaperWM.state.windowList(spaceID)
	if not columns then
		return
	end

	-- Clamp target position to valid range
	targetPosition = math.max(1, math.min(targetPosition, #columns))

	if currentCol == targetPosition then
		return
	end

	-- Remove from current position
	local column = PaperWM.state.windowList(spaceID, currentCol)
	local window = table.remove(column, index.row)

	-- Insert at target position
	table.insert(columns, targetPosition, { window })

	-- Re-tile the space
	PaperWM:tileSpace(spaceID)
end

local wf = hs.window.filter.new(nil)
wf:subscribe(hs.window.filter.windowCreated, function(win, appName)
	local placement = appPlacement[appName]
	if placement then
		hs.timer.doAfter(1, function()
			-- Create spaces if they don't exist
			ensureSpacesExist(placement.space)

			-- Focus the window first so PaperWM moves it
			win:focus()
			print("Moving " .. appName .. " to Space " .. placement.space)
			-- Move to target space
			PaperWM.space.moveWindowToSpace(placement.space)

			-- Wait for tiling to complete, then reposition and resize
			if placement.position or placement.width then
				hs.timer.doAfter(1.5, function()
					if placement.position then
						print("Repositioning " .. appName .. " to position " .. placement.position)
						repositionWindow(win, placement.position)
					end
					if placement.width then
						print("Resizing " .. appName .. " to width ratio " .. placement.width)
						resizeWindow(win, placement.width)
					end
				end)
			end
		end)
	end
end)

-- Arrange all apps according to appPlacement rules
local function arrangeAllApps()
	-- Sort apps by position so they're placed in the correct order
	local sortedApps = {}
	for appName, placement in pairs(appPlacement) do
		table.insert(sortedApps, { name = appName, placement = placement })
	end
	table.sort(sortedApps, function(a, b)
		return (a.placement.position or 999) < (b.placement.position or 999)
	end)

	-- Use a window filter that can see all windows across all spaces
	local allWindowsFilter = hs.window.filter.new(nil):setCurrentSpace(nil)
	local allWindows = allWindowsFilter:getWindows()

	-- Process each app with delays to allow operations to complete
	local delay = 0
	for _, app in ipairs(sortedApps) do
		local appName = app.name
		local placement = app.placement

		-- Find windows for this app from all windows
		for _, win in ipairs(allWindows) do
			local winAppName = win:application() and win:application():name()
			if winAppName == appName and win:isStandard() and not win:isMinimized() then
				-- Schedule this window's arrangement
				hs.timer.doAfter(delay, function()
					print("Arranging " .. appName)

					-- Check if window needs to move to a different space
					local currentSpace = hs.spaces.windowSpaces(win)[1]
					local targetSpaceID = PaperWM.space.MissionControl:getSpaceID(placement.space)

					if currentSpace ~= targetSpaceID then
						-- Move to target space using our custom function
						moveWindowToSpace(win, placement.space)

						-- Wait for move to complete, then reposition and resize
						hs.timer.doAfter(2, function()
							if placement.position then
								repositionWindow(win, placement.position)
							end
							if placement.width then
								resizeWindow(win, placement.width)
							end
						end)
					else
						-- Already on correct space, just reposition and resize
						if placement.position then
							repositionWindow(win, placement.position)
						end
						if placement.width then
							resizeWindow(win, placement.width)
						end
					end
				end)
				delay = delay + 4 -- Stagger each window operation (Mission Control needs time)
			end
		end
	end

	if delay == 0 then
		print("No windows found to arrange")
	else
		print("Arranging windows... this will take " .. delay .. " seconds")
	end
end

-- Bind arrange all apps to a hotkey
hs.hotkey.bind({ "alt", "cmd" }, "a", arrangeAllApps)

PaperWM:bindHotkeys({
	-- switch to a new focused window in tiled grid
	focus_left = { { "alt" }, "n" },
	focus_right = { { "alt" }, "o" },
	focus_up = { { "alt" }, "i" },
	focus_down = { { "alt" }, "e" },

	-- switch windows by cycling forward/backward
	-- (forward = down or right, backward = up or left)
	-- focus_prev = { "alt", "shift", "tab" },
	-- focus_next = { "alt", "tab" },

	-- move windows around in tiled grid
	swap_left = { { "alt", "shift" }, "n" },
	swap_right = { { "alt", "shift" }, "o" },
	swap_up = { { "alt", "shift" }, "i" },
	swap_down = { { "alt", "shift" }, "e" },

	-- position and resize focused window
	center_window = { { "alt" }, "c" },
	full_width = { { "alt" }, "f" },

	cycle_width = { { "alt" }, "r" },
	-- reverse_cycle_width = { {  }, "" },
	cycle_height = { { "alt", "ctrl" }, "r" },
	-- reverse_cycle_height = { { }, "" },

	-- increase/decrease width
	increase_width = { { "alt", "cmd" }, "o" },
	decrease_width = { { "alt", "cmd" }, "n" },

	-- move focused window into / out of a column
	slurp_in = { { "alt", "cmd" }, "i" },
	barf_out = { { "alt", "cmd", "shift" }, "i" },

	-- move the focused window into / out of the tiling layer
	toggle_floating = { { "alt", "cmd", "shift" }, "escape" },
	-- raise all floating windows on top of tiled windows
	focus_floating = { { "alt", "cmd", "shift" }, "f" },

	-- focus the first / second / etc window in the current space
	focus_window_1 = { { "cmd", "shift" }, "1" },
	focus_window_2 = { { "cmd", "shift" }, "2" },
	focus_window_3 = { { "cmd", "shift" }, "3" },
	focus_window_4 = { { "cmd", "shift" }, "4" },
	focus_window_5 = { { "cmd", "shift" }, "5" },

	-- switch to a new Mission Control space
	switch_space_l = { { "alt" }, "," },
	switch_space_r = { { "alt" }, "." },
	switch_space_1 = { { "alt" }, "1" },
	switch_space_2 = { { "alt" }, "2" },
	switch_space_3 = { { "alt" }, "3" },
	switch_space_4 = { { "alt" }, "4" },
	switch_space_5 = { { "alt" }, "5" },
	switch_space_6 = { { "alt" }, "6" },
	switch_space_7 = { { "alt" }, "7" },
	switch_space_8 = { { "alt" }, "8" },
	switch_space_9 = { { "alt" }, "9" },

	-- move focused window to a new space and tile
	move_window_1 = { { "alt", "shift" }, "1" },
	move_window_2 = { { "alt", "shift" }, "2" },
	move_window_3 = { { "alt", "shift" }, "3" },
	move_window_4 = { { "alt", "shift" }, "4" },
	move_window_5 = { { "alt", "shift" }, "5" },
	move_window_6 = { { "alt", "shift" }, "6" },
	move_window_7 = { { "alt", "shift" }, "7" },
	move_window_8 = { { "alt", "shift" }, "8" },
	move_window_9 = { { "alt", "shift" }, "9" },
})

-- Trackpad swiping to move wndows.
-- Have to set trackpad swiping between full window applications to 4 fingers in System Settings, then set PaperWM.swipe_fingers = 3 for this to work. It's a little janky January 2026.
-- number of fingers to detect a horizontal swipe, set to 0 to disable (the default)
-- PaperWM.swipe_fingers = 3

-- increase this number to make windows move farther when swiping
-- PaperWM.swipe_gain = 2.0

-- Ignore Apps
PaperWM.window_ratios = { 1 / 2, 2 / 3, 6 / 7 }
PaperWM.window_filter:rejectApp("Fantastical Helper")

PaperWM:start()
