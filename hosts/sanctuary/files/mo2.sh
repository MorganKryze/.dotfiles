#!/bin/sh
# Launcher for the MO2 non-Steam shortcut: Steam option `/home/morgan/mo2.sh %command%`.
LIB="$HOME/.local/share/Steam"
export STEAM_COMPAT_DATA_PATH="$LIB/steamapps/compatdata/377160"
export STEAM_COMPAT_INSTALL_PATH="$LIB/steamapps/common/Fallout 4"
export STEAM_COMPAT_LIBRARY_PATHS="$LIB/steamapps"
export SteamAppId=377160
# Microsoft XAudio2 (installed with `protontricks 377160 xact`) instead of
# Proton's FAudio: same fix as on the Mac for missing music and audio lag.
export WINEDLLOVERRIDES="xaudio2_7,x3daudio1_7=n,b"
# On-screen counters, off by default. To show them, prefix the Steam launch options with
# DXVK_HUD=fps,frametimes,gpuload,memory
exec "$@"
