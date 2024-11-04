-- Helper function:
-- returns color scheme dependant on operating system theme setting (dark/light)
local function color_scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Tokyo Night"
  else
    return "Tokyo Night Day"
  end
end

-- Pull in WezTerm API
local wezterm = require 'wezterm'

-- Initialize actual config
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Appearance
config.font_size = 14.0
config.color_scheme = color_scheme_for_appearance(wezterm.gui.get_appearance())
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = false

-- Return config to WezTerm
return config
