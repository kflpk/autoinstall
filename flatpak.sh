#!/bin/bash

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y com.discordapp.Discord
flatpak install -y org.signal.Signal
flatpak install -y com.spotify.Client
flatpak install -y com.microsoft.Teams
flatpak install -y org.telegram.desktop
flatpak install -y flatseal
