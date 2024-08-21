#!/bin/bash

cp ~/.dotfiles/services/plist/fr.kodelab.brew_update.plist ~/Library/LaunchAgents/fr.kodelab.brew_update.plist
launchctl load ~/Library/LaunchAgents/fr.kodelab.brew_update.plist