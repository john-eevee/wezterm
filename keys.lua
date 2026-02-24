local wezterm = require("wezterm")
local layouts = require("./layouts")

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

local M = {}

M.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

M.keys = {
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
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
		key = "E",
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
			local tab = window:active_tab()
			tab:set_title(get_cwd_name(tab))
		end),
	},
}

return M
