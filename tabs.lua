local wezterm = require("wezterm")

local M = {}

local function get_cwd_name(tab)
	local active_pane = tab.active_pane
	local cwd_url = active_pane.current_working_dir

	local function to_string(url)
		if type(url) == "string" then
			return url
		end
		return url.file_path
	end

	local title = "WezTerm"

	if cwd_url then
		local cwd = to_string(cwd_url)
		cwd = cwd:gsub("file://[^/]+", "")
		title = cwd:match("([^/]+)$") or "/"
	end
	return title
end

function M.format_tab_title(tab, _, _, _, hover, _)
	local background = "#191724"
	local foreground = "#908caa"

	if tab.is_active then
		background = "rgba(0,0,0,0)"
		foreground = "#eb6f92"
	elseif hover then
		background = "#26233c"
		foreground = "#e0def4"
	end

	local title = get_cwd_name(tab)
	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. title .. " " },
	}
end

return M
