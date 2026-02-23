local wezterm = require("wezterm")
local layouts = require("./layouts")
local config = wezterm.config_builder()
config.default_prog = { "fish" }
config.color_scheme = "Catppuccin Mocha"
local fontname = "Iosevka Term"
config.font = wezterm.font(fontname)
config.font_size = 12.0
config.line_height = 1.39
config.window_background_opacity = 0.90
config.text_background_opacity = 1.0

config.window_decorations = "RESIZE"
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 10,
}

config.front_end = "WebGpu"
config.max_fps = 60
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.colors = {
	tab_bar = {
		background = "rgba(0,0,0,0)",
	},
}

wezterm.on("format-tab-title", function(tab, _, _, _, hover, _)
	local background = "#191724"
	local foreground = "#908caa"

	if tab.is_active then
		background = "rgba(0,0,0,0)"
		foreground = "#eb6f92"
	elseif hover then
		background = "#26233c"
		foreground = "#e0def4"
	end

	local title = tab.active_pane.title
	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. title .. " " },
	}
end)

-- 6. TMUX-LIKE KEYBINDINGS
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Split horizontal
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Split vertical
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Spawn tab (new window in tmux)
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	-- Panes navigation
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	-- Panes resizing
	{
		key = "H",
		mods = "LEADER|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "J",
		mods = "LEADER|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "K",
		mods = "LEADER|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "L",
		mods = "LEADER|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "E", -- 'E' for Edit
		mods = "CTRL|SHIFT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			layouts.project_window(window, pane)
		end),
	},
}
config.mouse_bindings = {
	-- Scrolling with the mouse wheel
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "NONE",
		-- Adjust the number below to make it slower or faster (1 is slowest)
		action = wezterm.action.ScrollByLine(-3),
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "NONE",
		action = wezterm.action.ScrollByLine(3),
	},
}
-- Helper function to convert URL to string
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- Find the active pane in this tab
	local active_pane = tab.active_pane
	local cwd_url = active_pane.current_working_dir
	local function to_string(url)
		if type(url) == "string" then
			return url
		end
		return url.file_path
	end

	-- Default title if we can't find the CWD
	local title = "WezTerm"

	if cwd_url then
		-- Convert the URL object to a string
		local cwd = to_string(cwd_url)

		-- Strip the 'file://' prefix and the hostname
		-- This handles different OS path formats
		cwd = cwd:gsub("file://[^/]+", "")

		-- Extract the last part of the path (the folder name)
		-- If we are at root '/', it defaults to '/'
		title = cwd:match("([^/]+)$") or "/"
	end

	return {
		{ Text = " " .. title .. " " },
	}
end)
return config
