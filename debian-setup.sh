#!/bin/bash

echo "------------------------------------------"
echo "        Starting System Setup "
echo "------------------------------------------"

# apt update
echo "System update started..."
sudo apt update && sudo apt upgrade
echo "System update finished"

# Sway
echo "------------------------------------------"
echo "        Setting up Sway"
echo "------------------------------------------"
sudo apt install -y \
  sway \
  waybar \
  swayidle \
  gtklock \
  xwayland \
  sway-notification-center \
  wl-clipboard \
  brightnessctl \
  xdg-desktop-portal-wlr \
  nwg-displays \
  nwg-look \
  network-manager-gnome \
  lxpolkit \
  thunar \
  thunar-archive-plugin \
  thunar-volman \
  gvfs-backends \
  pipewire-audio \
  pavucontrol \
  avahi-daemon \
  acpi \
  acpid \
  xdg-user-dirs-gtk \
  kanshi \

sudo apt install -y lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
sudo systemctl enable lightdm
sudo systemctl set-default graphical.target

echo "------------------------------------------"
echo "        XDG DIRs SETUP"
echo "------------------------------------------"
xdg-user-dirs-update


# 1Password - Installing the file configures 1Passowrd's repo
echo "------------------------------------------"
echo "        1Password Setup"
echo "------------------------------------------"
echo "Installing 1Password"
curl -fsSL -o /tmp/1password.deb \
  "https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb"
sudo apt install -y /tmp/1password.deb

# Installing system utilities
echo "------------------------------------------"
echo "        System Utilities"
echo "------------------------------------------"
sudo apt install -y \
  libnotify-bin \
  zathura \
  sxiv \
  tmux \
  bat \
  lazygit \
  syncthing \
  thunar \
  btop \
  fuzzel \
  fzf \
  fastfetch \
  copyq \
  curl \
  grim \
  slurp\
  swappy \
  blueman \
  tree \
  okular \
  libreoffice \
  gh \
  git \
  kitty \
  mpv \
  neovim \
  qbittorrent \
  ranger \
  sqlite3 \
  stow \



# Firefox
echo "------------------------------------------"
echo "        Firefox Setup"
echo "------------------------------------------"
# Remove firefox ESR
sudo apt purge firefox-esr 'firefox-esr-l10n*' || true
sudo apt autoremove --purge
rm -rf ~/.mozilla/firefox
# Install Firefox from firefox repo
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
cat <<EOF | sudo tee /etc/apt/sources.list.d/mozilla.sources
Types: deb
URIs: https://packages.mozilla.org/apt
Suites: mozilla
Components: main
Signed-By: /etc/apt/keyrings/packages.mozilla.org.asc
EOF
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
sudo apt-get update && sudo apt-get install firefox
# Firefoxpwa
sudo apt install -y firefoxpwa

# Fonts
echo "------------------------------------------"
echo "        FONTS"
echo "------------------------------------------"
sudo apt install -y \
  fonts-jetbrains-mono \
  fonts-font-awesome \
  fonts-recommended \
  fonts-noto-color-emoji

# Install Flatpak apps
echo "------------------------------------------"
echo "        Flatpak"
echo "------------------------------------------"
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y \
  app.zen_browser.zen \
  com.bambulab.BambuStudio \
  com.discordapp.Discord \
  com.getpostman.Postman \
  com.github.tchx84.Flatseal \
  com.slack.Slack \
  com.ticktick.TickTick \
  com.visualstudio.code \
  io.dbeaver.DBeaverCommunity \
  it.mijorus.gearlever \
  md.obsidian.Obsidian \
  org.munadi.Munadi \
  org.telegram.desktop \


# Install Homebrew packages
echo "------------------------------------------"
echo "        Homebrew"
echo "------------------------------------------"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install \
  jesseduffield/lazydocker/lazydocker \

# Docker
echo "------------------------------------------"
echo "        INSTALLING DOCKER"
echo "------------------------------------------"
#  docker-buildx-plugin \
#  docker-ce \
#  docker-ce-cli \
#  docker-compose-plugin \
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
sudo apt update && \
sudo apt install -y \
  docker-ce=5:28.5.2-1~debian.13~trixie \
  docker-ce-cli=5:28.5.2-1~debian.13~trixie \
  containerd.io docker-buildx-plugin docker-compose-plugin && \
sudo apt-mark hold docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "------------------------------------------"
echo "        Copying Configs"
echo "------------------------------------------"
cd ..
rm .bashrc
git clone https://github.com/zphrio/zphr-linux-config
cd zphr-linux-config
stow bash
stow fuzzel
stow ideavim
stow kitty
stow ranger
stow sway
stow tmux
stow vim
stow waybar
