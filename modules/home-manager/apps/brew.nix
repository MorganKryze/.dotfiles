{ ... }:

{
  homebrew = {
    # Will remove all the packages that are not in the configuration
    onActivation.cleanup = "zap";
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    # Taps
    taps =
      [
      ];

    # Non-cask apps
    brews = [
      # Core utilities
      "p7zip"
      "poppler"
      "pkg-config"
      "graphviz"
      "ffmpegthumbnailer"
      "sevenzip"
      "jq"
      "fd"
      "ripgrep"
      "fzf"
      "zoxide"
      "imagemagick"

      # Langs
      "php"
      "pnpm"
      "openjdk"
      "gradle"

      # Terminal
      "htop"
      "btop"
      "lsd"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
      "zsh-autopair"
      "micro"

      # Dockers
      "postgresql@14"

      # Kubernetes
      "kubernetes-cli"
      "helm"
      "k9s"
      "kind"

      # Virtualization
      "qemu"

      # Games
      "cmatrix"
      "fortune"
      "sl"

      # Tools
      "mailsy"
      "yazi"
      "cowsay"
      "pygments"
    ];

    # Cask apps
    casks = [
      # Fonts
      "font-symbols-only-nerd-font"
      "font-hack-nerd-font"

      # Docker
      "docker"
      "miniconda"

      # Virtualization
      "vagrant"
      "virtualbox"
      "raspberry-pi-imager"
      "crystalfetch"
      "balenaetcher"
      "virtualbuddy"

      # ObjectiveSee & Safety
      "oversight"
      "lulu"
      "knockknock"
      "blockblock"
      "reikey"
      "bitwarden"
      # "protonvpn"
      "surfshark"

      # Browsers
      "arc"
      "zen-browser"
      "tor-browser"

      # Dev apps
      "visual-studio-code"
      "devtoys"
      "android-studio"
      "mactex"
      "applite"
      "wezterm"

      # Productivity
      "notion"
      "raycast"
      "maccy"
      "cheatsheet"
      "libreoffice"

      # 3D & Design
      "autodesk-fusion"
      "orcaslicer"
      "lycheeslicer"
      "kicad"
      "drawio"

      # Media
      "iina"
      "imageoptim"
      "inkscape"
      "flameshot"
      "handbrake"
      "adobe-acrobat-reader"
      "obs"

      # Communication
      "thunderbird@esr"
      "signal"
      "discord"
      "telegram"

      # Utilities
      "onyx"
      "appcleaner"
      "the-unarchiver"
      "stats"
      "keyboardcleantool"
      "mediamate"
      "lunar"
      "parsec"
      "jdownloader"

      # Games & Emulators
      "steam"
      "crossover"
      "whisky"
      "battle-net"
      "modrinth"
    ];

    # Mac App Store apps
    masApps = { };
  };
}
