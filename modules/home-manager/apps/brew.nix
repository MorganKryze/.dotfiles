{ ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      # Will remove all the packages that are not in the configuration
      cleanup = "zap";
      autoUpdate = true;
      # Set to false if a sha mismatch is detected to complete the build
      upgrade = true;
      extraFlags = [ "--verbose" ];
    };

    # Taps
    taps = [ ];

    # Non-cask apps
    brews = [
      # Core utilities
      "curl"
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
      "dotnet"

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
      "lynis"
      "mas"
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
      "windows-app"

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
      "firefox"

      # Dev apps
      "visual-studio-code"
      "devtoys"
      "android-studio"
      "mactex"
      "applite"
      "wezterm"
      "wireshark"
      "ghostty"

      # Productivity
      "notion"
      "raycast"
      "maccy"
      "cheatsheet"
      "libreoffice"

      # 3D & Design
      "autodesk-fusion"
      "orcaslicer"
      "kicad"
      "drawio"
      "freecad"
      "snapmaker-luban"

      # Media
      "iina"
      "imageoptim"
      "inkscape"
      "flameshot"
      "handbrake"
      "adobe-acrobat-reader"
      "obs"
      "jellyfin-media-player"
      "upscayl"

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
      "wkhtmltopdf"

      # Games & Emulators
      "steam"
      "crossover"
      "whisky"
      "battle-net"
      "modrinth"

      # Danger zone : app with known sha issues
      "lycheeslicer"
    ];

    # Mac App Store apps
    masApps = {
      "iMovie" = 408981434;
    };
  };
}
