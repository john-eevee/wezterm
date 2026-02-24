local wezterm = require("wezterm")

local M = {}

M.default_prog = { "fish" }
M.color_scheme = "Catppuccin Mocha"

local fontname = "CartographCF"
M.font = wezterm.font(fontname, { weight = "Light" })
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

M.freetype_load_flags = "FORCE_AUTOHINT"
M.max_fps = 60
for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
	if gpu.backend == "Vulkan" and gpu.device_type == "DiscreteGpu" then
		M.webgpu_preferred_adapter = gpu
		M.front_end = "WebGpu"
		break
	end
end
return M
