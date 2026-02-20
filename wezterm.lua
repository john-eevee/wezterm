local wezterm = require("wezterm")

-- Create the configuration builder
local config = wezterm.config_builder()
-- The '-l' flag ensures it runs as a login shell to load your profile correctly.
config.default_prog = { "fish" }
-- config.color_scheme = "Sakura (base16)"
config.color_scheme = "Catppuccin Mocha"
-- 3. FONT
-- WezTerm bundles JetBrains Mono by default.
-- If you use icons in your prompt (like Starship), ensure you use a Nerd Font.
-- local fontname = "SFMono Nerd Font Mono"
local fontname = "Iosevka Term"
config.font = wezterm.font(fontname)
config.font_size = 12.0
config.line_height = 1.39
-- 4. WINDOW AESTHETICS
-- Slight transparency to match the CachyOS/Arch modern feel.
config.window_background_opacity = 0.90
config.text_background_opacity = 1.0

-- Clean up the window look (removes title bar)
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 10,
}

config.front_end = "WebGpu"
config.max_fps = 60
-- 5. TAB BAR
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.colors = {
	tab_bar = {
		background = "rgba(0,0,0,0)",
	},
}

-- Minimal tab styling
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
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
return config
