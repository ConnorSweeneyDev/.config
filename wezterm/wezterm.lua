local wezterm = require("wezterm")
local config = wezterm.config_builder()

----------------------------------------------------------------------------------------------------

config.default_prog = { "pwsh", "-NoLogo" }
config.default_cwd = "C:/"
config.max_fps = 144
config.animation_fps = 144

----------------------------------------------------------------------------------------------------

config.leader = { key = "w", mods = "ALT", timeout_milliseconds = 1000 }
config.keys = {
  { key = "a", mods = "ALT | SHIFT", action = wezterm.action.ActivateTab(0) },
  { key = "s", mods = "ALT | SHIFT", action = wezterm.action.ActivateTab(1) },
  { key = "d", mods = "ALT | SHIFT", action = wezterm.action.ActivateTab(2) },
  { key = "f", mods = "ALT | SHIFT", action = wezterm.action.ActivateTab(3) },
  { key = "h", mods = "ALT | SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
  { key = "l", mods = "ALT | SHIFT", action = wezterm.action.ActivateTabRelative(1) },
  { key = "z", mods = "ALT | SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
  { key = "t", mods = "ALT | SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "w", mods = "ALT | SHIFT", action = wezterm.action.SpawnWindow },
  { key = "j", mods = "ALT | SHIFT", action = wezterm.action.ScrollByLine(12) },
  { key = "k", mods = "ALT | SHIFT", action = wezterm.action.ScrollByLine(-12) },
  { key = "c", mods = "ALT | SHIFT", action = wezterm.action.CopyTo("Clipboard") },
  { key = "v", mods = "ALT | SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
  { key = "f", mods = "LEADER | ALT", action = wezterm.action.Search({ CaseSensitiveString = "" }) },
  { key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b\r" }) },
  {
    key = "e",
    mods = "LEADER | ALT",
    action = wezterm.action_callback(function(_, pane)
      local cwd_url = pane:get_current_working_dir()
      local cwd = cwd_url.file_path:sub(2)
      wezterm.open_with(cwd)
    end),
  },
  {
    key = "v",
    mods = "LEADER | ALT",
    action = wezterm.action.SpawnCommandInNewTab({
      args = { "pwsh", "-NoExit", "-Command", "./script/clean.bat" },
      domain = "CurrentPaneDomain",
    }),
  },
  {
    key = "b",
    mods = "LEADER | ALT",
    action = wezterm.action.SpawnCommandInNewTab({
      args = { "pwsh", "-NoExit", "-Command", "./script/build.bat" },
      domain = "CurrentPaneDomain",
    }),
  },
  {
    key = "n",
    mods = "LEADER | ALT",
    action = wezterm.action.SpawnCommandInNewTab({
      args = { "pwsh", "-NoExit", "-Command", "./script/run.bat" },
      domain = "CurrentPaneDomain",
    }),
  },
  {
    key = "m",
    mods = "LEADER | ALT",
    action = wezterm.action.SpawnCommandInNewTab({
      args = { "pwsh", "-NoExit", "-Command", "./script/debug.bat" },
      domain = "CurrentPaneDomain",
    }),
  },
}

----------------------------------------------------------------------------------------------------

config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "NONE | RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_background_opacity = 0.7
config.use_fancy_tab_bar = false
config.tab_max_width = 100

----------------------------------------------------------------------------------------------------

config.font_size = 20
config.freetype_load_target = "Light"
config.font = wezterm.font({
  family = "CaskaydiaCove NF",
  weight = "DemiBold",
  harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
})

----------------------------------------------------------------------------------------------------

local foreground = "rgb(225, 225, 225)"
local background = "rgb(10, 10, 10)"
local transparent_background = "rgba(10, 10, 10, 0.7)"
local transparent_hover = "rgba(30, 30, 30, 0.7)"
local inactive_foreground = "rgb(100, 100, 100)"
config.color_scheme = "Apple System Colors"
config.colors = {
  foreground = foreground,
  background = background,
  cursor_fg = background,
  cursor_bg = foreground,

  tab_bar = {
    background = transparent_background,

    active_tab = { bg_color = transparent_background, fg_color = foreground },
    inactive_tab = { bg_color = transparent_background, fg_color = inactive_foreground },
    inactive_tab_hover = { bg_color = transparent_hover, fg_color = inactive_foreground },

    new_tab = { bg_color = transparent_background, fg_color = inactive_foreground },
    new_tab_hover = { bg_color = transparent_hover, fg_color = inactive_foreground },
  },
}

----------------------------------------------------------------------------------------------------

return config
