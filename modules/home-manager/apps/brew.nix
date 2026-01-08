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

    taps = [
      # "leoafarias/fvm" # Flutter Version Management
      "krtirtho/apps" # Custom apps by krtirtho
      "krishkrosh/apps" # Custom apps by krishkrosh
    ];

    brews = [
      # ============================================ Development ======================================================
      #
      # Cmake: Cross-platform build system.
      "cmake"
      # Libuv: Multi-platform support library with a focus on asynchronous I/O.
      "libuv"
      # Hwloc: Hardware locality library for managing hardware resources.
      "hwloc"
      # Curl: Command-line tool for transferring data with URLs.
      "curl"
      # Fd: Simple, fast and user-friendly alternative to 'find'.
      "fd"
      # Ffmpegthumbnailer: Create thumbnails for your video files.
      "ffmpegthumbnailer"
      # Ffmpeg: Complete, cross-platform solution to record, convert and stream audio and video.
      "ffmpeg"
      # Fvm: Flutter Version Management.
      # "fvm"
      # Fzf: Command-line fuzzy finder.
      "fzf"
      # Graphviz: Graph visualization software.
      "graphviz"
      # Imagemagick: Software suite to create, edit, compose, or convert bitmap images.
      "imagemagick"
      # Jq: Lightweight and flexible command-line JSON processor.
      "jq"
      # P7zip: Command-line version of the 7zip file archiver.
      "p7zip"
      # Php: General-purpose scripting language especially suited to web development.
      "php"
      # Pkg-config: Helper tool used when compiling applications and libraries.
      "pkg-config"
      # Poppler: PDF rendering library.
      "poppler"
      # Pnpm: Fast, disk space efficient package manager.
      "pnpm"
      # Prettier: Opinionated code formatter.
      "prettier"
      # Pygments: Generic syntax highlighter suitable for use in code hosting, forums, wikis or other applications that need to prettify source code.
      "pygments"
      # Python version for ROS.
      "python@3.9"
      # Ripgrep: Line-oriented search tool that recursively searches your current directory for a regex pattern.
      "ripgrep"
      # Socat: Multipurpose relay for bidirectional data transfer.
      "socat"
      # Sevenzip: File archiver with a high compression ratio.
      "sevenzip"
      # Uv: Lightweight, high-performance web server.
      "uv"
      # Zoxide: Smarter cd command, inspired by z and autojump.
      "zoxide"

      # ============================================ Terminal ==========================================================
      #
      # Btop: Resource monitor that shows usage and stats for processor, memory, disks, network and processes.
      "btop"
      # Htop: Interactive process viewer for Unix systems.
      "htop"
      # Lsd: Next-gen ls command with a lot of pretty colors and awesome icons.
      "lsd"
      # Micro: Modern and intuitive terminal-based text editor.
      "micro"
      # Zsh-autopair: Zsh plugin for auto-pairing of brackets and quotes.
      "zsh-autopair"
      # Zsh-autosuggestions: Fish-like autosuggestions for Zsh.
      "zsh-autosuggestions"
      # Zsh-syntax-highlighting: Syntax highlighting for Zsh.
      "zsh-syntax-highlighting"

      # ========================================== Docker & Kube =======================================================
      #
      # Helm: Kubernetes package manager.
      "helm"
      # K9s: Kubernetes CLI to manage your clusters in style.
      "k9s"
      # Kind: Kubernetes IN Docker - local clusters for testing Kubernetes.
      # "kind"
      # Kubernetes-cli: Command-line tool for interacting with Kubernetes clusters.
      "kubernetes-cli"
      # Postgresql@14: Powerful, open-source object-relational database system.
      "postgresql@14"
      # Minikube: Run Kubernetes locally.
      "minikube"
      # Kubectl: Kubernetes command-line tool.
      "kubectl"

      # ========================================== Virtualization ======================================================
      #
      # Qemu: Generic and open-source machine emulator and virtualizer.
      "qemu"

      # ============================================ Games =============================================================
      #
      # Fortune: Program that displays a random quotation.
      "fortune"
      # Cmatrix: Terminal-based "The Matrix" like implementation.
      "cmatrix"
      # Cowsay: Configurable speaking/thinking cow.
      "cowsay"
      # Sl: Joke command, runs a steam locomotive across your terminal.
      "sl"

      # ============================================ Utilities =========================================================
      #
      # Lynis: Security auditing tool for Unix-based systems.
      "lynis"
      # Mas: Mac App Store command-line interface.
      "mas"
    ];

    casks = [
      # ============================================ Fonts =============================================================
      #
      # Font-hack-nerd-font: Nerd Font with Hack.
      "font-hack-nerd-font"
      # Font-symbols-only-nerd-font: Nerd Font with only symbols.
      "font-symbols-only-nerd-font"

      # ============================================== Docker ==========================================================
      #
      # Docker: Platform for developing, shipping, and running applications.
      "docker-desktop"
      # Miniconda: Minimal installer for conda.
      "miniconda"
      # Xquartz: X.Org X Window System that runs on macOS.
      "xquartz"

      # ============================================== Virtualization ==================================================
      #
      # Balenaetcher: Flash OS images to SD cards & USB drives.
      "balenaetcher"
      # Crystalfetch: Fetch system information.
      # "crystalfetch"
      # Raspberry-pi-imager: Raspberry Pi imaging utility.
      "raspberry-pi-imager"
      # Utm: Virtual machines for Mac.
      # "utm"
      # Virtualbox: Powerful x86 and AMD64/Intel64 virtualization product.
      "virtualbox"
      # Virtualbuddy: macOS virtual machine manager.
      # "virtualbuddy"
      # Windows-app: Run Windows apps on macOS.
      # "windows-app"

      # ============================================== Security ========================================================
      #
      # Bitwarden: Open-source password manager.
      "bitwarden"
      # Blockblock: Block persistent malware.
      "blockblock"
      # Knockknock: See what's persistently installed on your Mac.
      "knockknock"
      # Lulu: macOS firewall.
      "lulu"
      # Oversight: Monitor macOS microphone and camera.
      "oversight"
      # Reikey: Keylogger detector.
      "reikey"
      # Surfshark: VPN service.
      # "surfshark"
      # Private-internet-access: VPN service.
      "private-internet-access"
      # Monero GUI: Monero cryptocurrency wallet.
      "monero-wallet"

      # ============================================== Browsers ========================================================
      #
      # Firefox: Web browser.
      "firefox"
      # Librewolf: Privacy-focused web browser.
      "librewolf"
      # Freetube: YouTube client for privacy.
      # "freetube"
      # Spotube: YouTube music player.
      # "spotube"
      # Tor-browser: Privacy-focused web browser.
      # "tor-browser"
      # Zen: Privacy-focused web browser.
      "zen"
      # Chrome: Web browser ONLY FOR FLUTTER DEV.
      # "google-chrome"
      # Brave: Privacy-focused web browser.
      "brave-browser"

      # ============================================== Development =====================================================
      #
      # Android-studio: Android development environment.
      "android-studio"
      # Devtoys: Swiss Army knife for developers.
      "devtoys"
      # Ghostty: Ghost typing tool.
      "ghostty"
      # Lm-studio: Language model studio.
      # "lm-studio"
      # Mactex: TeX distribution for macOS.
      "mactex"
      # Qflipper: Flipper Zero firmware manager.
      "qflipper"
      # Visual-studio-code: Code editor.
      "visual-studio-code"
      # Arduino: Open-source electronics platform.
      "arduino-ide"
      # Antigravity: Google IDE
      "antigravity"

      # ============================================== Productivity ====================================================
      #
      # Dockdoor: Window switcher.
      "dockdoor"
      # Cheatsheet: View available keyboard shortcuts.
      "cheatsheet"
      # Libreoffice: Open-source office suite.
      "libreoffice"
      # Maccy: Clipboard manager.
      "maccy"
      # Notion: All-in-one workspace.
      "notion"
      # Raycast: Productivity tool.
      "raycast"

      # ============================================== Design ==========================================================
      #
      # Autodesk-fusion: 3D CAD, CAM, and CAE tool.
      # "autodesk-fusion"
      # Drawio: Diagramming tool.
      # "drawio"
      # Freecad: Open-source parametric 3D CAD modeler.
      "freecad"
      # Kicad: Open-source EDA software.
      "kicad"
      # Orcaslicer: 3D printing slicer.
      "orcaslicer"
      # Snapmaker-luban: 3D printing software.
      # "snapmaker-luban"

      # ============================================== Media ===========================================================
      #
      # Flameshot: Screenshot tool.
      # "flameshot"
      # Handbrake: Video transcoder.
      "handbrake-app"
      # Iina: Modern media player.
      "iina"
      # Imageoptim: Image optimization tool.
      "imageoptim"
      # Inkscape: Vector graphics editor.
      "inkscape"
      # Obs: Open-source streaming and recording software.
      "obs"
      # Upscayl: AI image upscaler.
      "upscayl"

      # ============================================== Communication ===================================================
      #
      # Discord: Chat for communities.
      "discord"
      # Ollama: AI assistant.
      # "ollama-app"
      # Signal: Private messaging app.
      "signal"
      # Telegram: Messaging app.
      "telegram"
      # Thunderbird@esr: Email client.
      "thunderbird@esr"

      # ============================================== Utilities =======================================================
      #
      # Appcleaner: App uninstaller.
      "appcleaner"
      # Jdownloader: Download manager.
      "jdownloader"
      # Keyboardcleantool: Disable keyboard for cleaning.
      "keyboardcleantool"
      # Lunar: Monitor brightness control.
      "lunar"
      # Mediamate: Media management tool.
      "mediamate"
      # Onyx: macOS maintenance tool.
      # "onyx"
      # Parsec: Remote desktop application.
      # "parsec"
      # Stats: System monitor.
      "stats"
      # The-unarchiver: File extraction tool.
      "the-unarchiver"
      # Wkhtmltopdf: Convert HTML to PDF.
      "wkhtmltopdf"
      # Ledger live: Personal cryptocurrency manager.
      "ledger-live"
      # Trezor suite: Cryptocurrency wallet.
      "trezor-suite"
      # Trackweight: Weight tracking app with the trackpad.
      # "trackweight"
      # Jellyfin: media server software.
      "jellyfin-media-player"

      # ============================================== Games ===========================================================
      #
      # Battle-net: Game launcher.
      "battle-net"
      # Hstracker: Hearthstone deck tracker.
      "hstracker"
      # Crossover: Run Windows applications on macOS.
      "crossover"
      # Modrinth: Minecraft mod manager.
      "modrinth"
      # Steam: Game distribution platform.
      "steam"
      # Whisky: macOS app for running Windows apps.
      "whisky"
    ];

    # Mac App Store apps
    masApps = {
      # iMovie: Video editing software.
      "iMovie" = 408981434;
      # Parcel - Delivery Tracking: Package tracking app.
      "Parcel - Delivery Tracking" = 639968404;
      # Amazon Prime Video: Streaming service app.
      # "Amazon Prime Video" = 545519333;
      # Manet Music: Music streaming app connected to Jellyfin server.
      # "Manet Music" = 6470928235;

    };
  };
}
