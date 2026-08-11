-- Pull in WezTerm API
local wezterm = require 'wezterm'

-- Initialize actual config
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Appearance
config.font_size = 14.0
config.color_scheme = "Tokyo Night"
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = false

-- SSH : laisser l'agent du système tranquille.
-- Par défaut WezTerm démarre SON PROPRE agent et écrase SSH_AUTH_SOCK (vers
-- ~/.local/share/wezterm/agent.<pid>). Les clés chargées par le service launchd
-- `ssh-add-keychain` atterrissent alors dans l'agent d'Apple, que le shell ne
-- regarde plus — et quand le processus WezTerm qui possédait la socket meurt,
-- `ssh-add -l` répond « Error connecting to agent: No such file or directory »
-- alors que les clés sont bien chargées, ailleurs. Vécu le 2026-08-11.
config.mux_enable_ssh_agent = false

-- Return config to WezTerm
return config
