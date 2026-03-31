local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Always start in Arch WSL
config.default_domain = "WSL:Arch"

-- Appearance
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 1

-- Tabs
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- Launch on right half
wezterm.on("gui-startup", function(cmd)
  local mux = wezterm.mux
  local gui = wezterm.gui

  local tab, pane, window = mux.spawn_window(cmd or {})
  local gui_win = window:gui_window()

  local screen = gui.screens().main

  -- Half width, full height
  local width = screen.width / 2
  local height = screen.height

  -- Position: right side
  local x = screen.x + width
  local y = screen.y

  gui_win:set_position(x, y)
  gui_win:set_inner_size(width, height)
end)

-- Show active key table
wezterm.on("update-right-status", function(window, pane)
  local name = window:active_key_table()
  if name then
    window:set_right_status("MODE: " .. name)
  else
    window:set_right_status("")
  end
end)

-- Font
config.font = wezterm.font("IosevkaTerm Nerd Font Mono")
config.font_size = 15.0

--  Scrollback
config.scrollback_lines = 10000

-- Cursor
-- config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 800

config.leader = { key = "b", mods = "CTRL" }

config.keys = {
  -- Split panes
  { key = "=", mods = "LEADER", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "-", mods = "LEADER", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },

  -- Navigate panes
  { key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Left" },
  { key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Right" },
  { key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Up" },
  { key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Down" },

  -- Tabs
  { key = "t", mods = "LEADER", action = wezterm.action.SpawnTab "CurrentPaneDomain" },
  { key = "d", mods = "LEADER", action = wezterm.action.CloseCurrentPane({confirm = false})},
  { key = "\\", mods = "LEADER", action = wezterm.action.CloseCurrentTab({confirm = false})},
  { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },

  -- Copy mode
  { key = "c", mods = "ALT", action = wezterm.action.ActivateCopyMode },

  -- Quick launcher
  { key = "p", mods = "CTRL|SHIFT", action = wezterm.action.ActivateCommandPalette },

  {
    key = "r",
    mods = "LEADER",
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },

}

config.key_tables = {
  resize_pane = {
    { key = "h", action = act.AdjustPaneSize {'Left', 1 } },
    { key = "l", action = act.AdjustPaneSize {'Right', 1 } },
    { key = "j", action = act.AdjustPaneSize {'Down', 1 } },
    { key = "k", action = act.AdjustPaneSize {'Up', 1 } },
    { key = "Escape", action = 'PopKeyTable' },
  },
}


return config
