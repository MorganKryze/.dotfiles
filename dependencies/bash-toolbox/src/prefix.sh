#!/bin/bash

# ================================== COLORS ===================================
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
ORANGE='\033[0;33m'
RESET='\033[0m'
LINK='\033[0;36m'
UNDERLINE='\033[4m'

# ================================ FUNCTIONS ==================================

# Displays a raw message.
# $1: The message to display.
function txt() {
    echo -e "${RESET}$1"
}

# Displays a blue message.
# $1: The message to display.
function blue() {
    txt "${BLUE}$1${RESET}"
}

# Displays a green message.
# $1: The message to display.
function green() {
    txt "${GREEN}$1${RESET}"
}

# Displays an error message when a command fails.
# $1: The error message to display.
function error {
  txt "[${RED}   ERROR   ${RESET}] $1${RESET}"
  return 1
}

# Displays an information message.
# $1: The message to display.
function info {
  echo "[${BLUE}    INFO   ${RESET}] $1${RESET}"
}

# Displays a warning message.
# $1: The message to display.
function warning {
  echo "[${ORANGE}  WARNING  ${RESET}] $1${RESET}"
}

# Displays a success message.
# $1: The message to display.
function success {
  echo "[${GREEN}  SUCCESS  ${RESET}] $1${RESET}"
}

# =============================================================================