
# Developper tools

## Terminal configuration

## Oh My Zsh

By default, the pre-configured shell on MacOS is zsh. Oh My Zsh is an open source, community-driven framework for managing your zsh configuration. It comes bundled with a ton of helpful functions, helpers, plugins, themes, and a few things that make you shout... "Oh My Zsh!". (Free | [Open source](https://ohmyz.sh/))

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

For the Theme part, I use bira, but you have a lot of choice. You can find them [here](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes). Do not forget to add it in your `.zshrc` file!

For the plugins, I use git, [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh) (gives you history of your commands) and [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh) (highlights in green if your command is valid). Once installed, you have to add them in the plugins section of your `.zshrc` file (like in the example above).

## neofetch

neoFetch is a command-line system information tool. It displays information about your system next to an image, generally your OS logo, or any ASCII file of your choice. This is only cosmetic and informative. (Free | [Open source](https://github.com/dylanaraps/neofetch))

```bash
brew install neofetch
```

> [!TIP]
> You will need to add `neofetch` to your `.zshrc` file to display it at the start of each terminal session.

## lsd

lsd is a modern ls command with a lot of options and visuals. (Free | [Open source](https://github.com/lsd-rs/lsd))

```bash
brew install lsd
```

> [!TIP]
> You may use lsd with all of the built-in flags or define your own aliases in your `.zshrc` file to make your life easier.

## z

z is a tool that allows you to navigate through your directories with ease. It is a must-have tool for developpers. (Free | [Open source](https://github.com/rupa/z))

```bash
brew install z
```

## statistics

htop is a tool that allows you to monitor your system's performance. (Free | [Open source](https://htop.dev/))

```bash
brew install htop
```

btop displays a monitor of ressources usage on your terminal. (Free | [Open source](https://github.com/aristocratos/btop))

```bash
brew install btop
```

## yabai

Yabai is a tiling window manager for macOS. It let you control your windows with your keyboard and gain a lot of time. To download and use it, I made this [repository](https://github.com/MorganKryze/Yabai-Setup).

## Git and versionning

Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency. (Free | [Open source](https://git-scm.com/))

```bash
brew install git
```

To visualize a control panel of your git workspace, you can use lazygit. (Free | [Open source](https://github.com/jesseduffield/lazygit))

```bash
brew install lazygit
```

### Environment managment

Miniconda is a free minimal installer for conda. It is a small, bootstrap version of Anaconda that includes only conda, Python, the packages they depend on, and a small number of other useful packages, including pip, zlib and a few others. You may use it to create development environments for many language including Python, R, Ruby, Lua, Scala, Java, JavaScript, C/ C++, C#... (Free | [Proprietary](https://docs.conda.io/en/latest/miniconda.html))

```bash
brew install miniconda
```

Then init conda with the following command:

```bash
conda init "$(basename "${SHELL}")"
```

### Containers

Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers. Containers are isolated from one another and bundle their own software, libraries and configuration files; they can communicate with each other through well-defined channels. (Free | [Open source](https://www.docker.com/))

```bash
brew install docker
```

To manage and visualize your containers, you can use lazydocker (same use as `lazygit`). (Free | [Open source](https://github.com/jesseduffield/lazydocker))

```bash
brew lazydocker
```

### IDE

Visual Studio Code is a source-code editor developed by Microsoft for Windows, Linux and macOS. It includes support for debugging, embedded Git control, syntax highlighting, intelligent code completion, snippets, and code refactoring. (Free | [Open source](https://github.com/microsoft/vscode))

```bash
brew install visual-studio-code
```
