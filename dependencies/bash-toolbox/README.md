![screenshot](./docs/assets/img/presentation.jpg)

## Overview

> UI tools for processes / functions feedbacks.

## Getting Started

- [Overview](#overview)
- [Getting Started](#getting-started)
  - [Documentation](#documentation)
  - [Setting up](#setting-up)
    - [Prerequisites](#prerequisites)
    - [Install](#install)
    - [Usage](#usage)
  - [Troubleshooting](#troubleshooting)
  - [Supported platforms](#supported-platforms)
  - [Contributing](#contributing)
  - [License](#license)

### Documentation

The repository defines colors variables from the bash values.

The functions themselves can be used following this example:

```bash
func $1
```

_Where "func" is the function used, and "$1" the append text._

### Setting up

#### Prerequisites

- bash environment (zsh, fish, or equivalent should work too.)
- git

#### Install

> [!TIP]
> This repository may not be used as a standalone project, but rather as a dependency for a project in need to give feedback about what's happening during execution.

You will only need to clone the repository:

```bash
git clone https://github.com/MorganKryze/bash-toolbox.git
```

#### Usage

Source the files to access their functions. Like this:

```bash
source ./bash-toolbox/src/prefix.sh ; info "tools are installed"
```

To access it globally, you will need to add the source instruction from your .bashrc (or equivalent) referencing the files with an absolute path.

### Troubleshooting

If you cannot access the functions, always check the path to the executable and your location with `pwd` in your terminal.

### Supported platforms

- MacOS
- Linux
- Windows (WSL or VM)

### Contributing

If you want to contribute to the project, you can follow the steps described in the [CONTRIBUTING](./.github/CONTRIBUTING) file.

### License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details.
