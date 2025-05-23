local wezterm = require "wezterm"
local config = wezterm.config_builder()

----------------------------------------------------------------------------------------------------

config.default_prog = {"pwsh", "-NoLogo"}
config.default_cwd = "C:/"
config.max_fps = 144
config.animation_fps = 144

----------------------------------------------------------------------------------------------------

config.leader = {key = "Tab", mods = "CTRL", timeout_milliseconds = 1000}
config.keys =
{
  {key = "Tab", mods = "LEADER | CTRL", action = wezterm.action.SendKey {key = "Tab", mods = "CTRL"}},
  {key = "a", mods = "LEADER | CTRL", action = wezterm.action.ActivateTab(0)},
  {key = "s", mods = "LEADER | CTRL", action = wezterm.action.ActivateTab(1)},
  {key = "d", mods = "LEADER | CTRL", action = wezterm.action.ActivateTab(2)},
  {key = "f", mods = "LEADER | CTRL", action = wezterm.action.ActivateTab(3)},
  {key = "h", mods = "LEADER | CTRL", action = wezterm.action.ActivateTabRelative(-1)},
  {key = "l", mods = "LEADER | CTRL", action = wezterm.action.ActivateTabRelative(1)},
  {key = "z", mods = "LEADER | CTRL", action = wezterm.action.CloseCurrentTab {confirm = false}},
  {key = "c", mods = "LEADER | CTRL", action = wezterm.action.CopyTo "Clipboard"},
  {key = "v", mods = "LEADER | CTRL", action = wezterm.action.PasteFrom "Clipboard"},
  {key = "j", mods = "LEADER | CTRL", action = wezterm.action.ScrollByPage(1)},
  {key = "k", mods = "LEADER | CTRL", action = wezterm.action.ScrollByPage(-1)},
  {key = "t", mods = "LEADER | CTRL", action = wezterm.action.SpawnTab "CurrentPaneDomain"},
  {key = "w", mods = "LEADER | CTRL", action = wezterm.action.SpawnWindow},
  {key = "f", mods = "LEADER", action = wezterm.action.Search {CaseSensitiveString=""}}
}

----------------------------------------------------------------------------------------------------

config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "NONE | RESIZE"
config.window_padding = {left = 0, right = 0, top = 0, bottom = 0}
config.window_background_opacity = 0.7
config.use_fancy_tab_bar = false
config.tab_max_width = 100

----------------------------------------------------------------------------------------------------

config.font_size = 20
config.freetype_load_target = "Light"
config.font = wezterm.font
{
  family = "CaskaydiaCove NF",
  weight = "DemiBold",
  harfbuzz_features = {"calt=1", "clig=1", "liga=1"}
}

----------------------------------------------------------------------------------------------------

local foreground = "rgb(225, 225, 225)"
local background = "rgb(10, 10, 10)"
local transparent_background = "rgba(10, 10, 10, 0.7)"
local transparent_hover = "rgba(30, 30, 30, 0.7)"
local inactive_foreground = "rgb(100, 100, 100)"
config.color_scheme = "Apple System Colors"
config.colors =
{
  foreground = foreground,
  background = background,
  cursor_fg = background,
  cursor_bg = foreground,

  tab_bar =
  {
    background = transparent_background,

    active_tab = {bg_color = transparent_background, fg_color = foreground},
    inactive_tab = {bg_color = transparent_background, fg_color = inactive_foreground},
    inactive_tab_hover = {bg_color = transparent_hover, fg_color = inactive_foreground},

    new_tab = {bg_color = transparent_background, fg_color = inactive_foreground},
    new_tab_hover = {bg_color = transparent_hover, fg_color = inactive_foreground}
  }
}

----------------------------------------------------------------------------------------------------

return config
