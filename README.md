# .dotfiles

> Personal dotfiles for my macOS environment.

![screenshot](./.github/presentation.png)

## Getting Started

### Introduction

This project is a collection of my personal dotfiles for my macOS environment. It contains the configuration files for the following tools:

- [Miniconda](https://docs.conda.io/en/latest/miniconda.html)
- [Git](https://git-scm.com/)
- [Zsh](https://www.zsh.org/)
- [iTerm2](https://iterm2.com/)
- [yabai](https://github.com/koekeishiya/yabai)
- [Homebrew](https://brew.sh/)
- [GitHub](https://github.com)

This project is the continuity of these previous projects:

- [Easy-Git](https://github.com/MorganKryze/easy-git)
- [Easy-Env](https://github.com/MorganKryze/easy-env)
- [Yabai-Setup](https://github.com/MorganKryze/yabai-setup)
- [Mac-Setup](https://github.com/MorganKryze/mac-setup)

### Documentation

- [General utility packages](./docs/tools/general.md)
- [Dev packages](./docs/tools/dev.md)

### Prerequisites

- macOS recent version
- Terminal.app

### Install

To install the dotfiles, you can follow the steps below:

1. Clone the repository:

```bash
cd ~
git clone git@github.com:MorganKryze/.dotfiles.git
```

Or download the repository as a zip file and extract it.

2. Run the installation script:

```bash
cd .dotfiles
./bootstrap.sh
```

3. Update the `.env.example` file with your personal information and rename it to `.env`. (Optional: remove it if you do not need these variables)

4. Restart your computer.

5. Enjoy!

## Supported platform

- macOS

## Roadmap

- [ ] document the brew packages (similar to [Mac-Setup](https://github.com/MorganKryze/mac-setup))
- [ ] document and improve [Easy-Git](https://github.com/MorganKryze/easy-git) work
- [ ] document and improve [Easy-Env](https://github.com/MorganKryze/easy-env) work
- [ ] document and improve [Yabai-Setup](https://github.com/MorganKryze/yabai-setup) work

## Acknowledgments

The acknowledgments are described in the [ACKNOWLEDGMENTS](./.github/ACKNOLEDGMENTS.md) file.

## Contributing

If you want to contribute to the project, you can follow the steps described in the [CONTRIBUTING](./.github/CONTRIBUTING.md) file.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.
