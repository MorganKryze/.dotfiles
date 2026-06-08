{ ... }:

# Starship config is owned by Home-Manager. The TOML file stays the
# editable source; settings = fromTOML (readFile ...) routes it through
# programs.starship so HM owns ~/.config/starship.toml.
# See ../../../../docs/packaging.md for the config-source policy.
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
