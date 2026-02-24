local wezterm = require("wezterm")
local keys = require("./keys")
local appearance = require("./appearance")
local tabs = require("./tabs")
local mouse = require("./mouse")

local config = wezterm.config_builder()

config.default_prog = appearance.default_prog
config.color_scheme = appearance.color_scheme
config.font = appearance.font
config.font_size = appearance.font_size
config.line_height = appearance.line_height

config.window_background_opacity = appearance.window_background_opacity
config.text_background_opacity = appearance.text_background_opacity

config.window_decorations = appearance.window_decorations
config.window_padding = appearance.window_padding

config.front_end = appearance.front_end
config.max_fps = appearance.max_fps
config.freetype_load_flags = appearance.freetype_load_flags
config.webgpu_preferred_adapter = appearance.webgpu_preferred_adapter
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32

config.colors = {
	tab_bar = {
		background = "rgba(0,0,0,0)",
	},
}

config.leader = keys.leader
config.keys = keys.keys
config.mouse_bindings = mouse.mouse_bindings

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	return tabs.format_tab_title(tab, tabs, panes, config, hover, max_width)
end)

return config
