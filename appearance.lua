local wezterm = require("wezterm")

local M = {}

M.default_prog = { "fish" }
M.color_scheme = "Catppuccin Mocha"

local fontname = "DepartureMono Nerd Font"
M.font = wezterm.font(fontname)
M.font_size = 11.0
M.line_height = 1.39

M.window_background_opacity = 0.90
M.text_background_opacity = 1.0

M.window_decorations = "RESIZE"
M.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

M.front_end = "WebGpu"
M.max_fps = 60

return M
