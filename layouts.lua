local mux = require("wezterm").mux

local M = {}

function M.project_window(window, _)
  local window_id = window:window_id()
  local mux_window = mux.get_window(window_id)
  local _, top, _ = mux_window:spawn_tab({})

  local bottom = top:split({
    direction = "Bottom",
    size = 0.2,
  })

  local bottom_right = bottom:split({
    direction = "Right",
    size = 0.2,
  })

  local top_right = top:split({
    direction = "Right",
    size = 0.2,
  })

  top:send_text("nvim\n")
  top_right:send_text("opencode\n")
  bottom_right:send_text("echo 'build and stuff'\n")
  bottom:send_text("echo 'runner'\n")

  top:activate()
end

return M
