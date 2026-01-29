#!/bin/bash
function check(){
  read -p '
  -----------
  1) Arch
  -----------
  2) Debian
  -----------
  -> ' name
  if [ "$name" == "1" ]; then
    sudo pacman -Sy
    sudo pacman -S i3 i3-gaps polybar obsidian lsd feh bat caja zathura fish picom python zsh slim btop zip unzip wget curl xclip rofi alacritty net-tools mpv flameshot ranger telegram-desktop kitty chromium firefox figlet base base-devel
    curl -O https://blackarch.org/strap.sh
  else
    if [ "$name" == "2" ]; then
      sudo apt update

      sudo apt-get install -y arandr curl zsh flameshot arc-theme feh i3blocks i3status i3 i3-wm lxappearance python3-pip rofi unclutter cargo compton papirus-icon-theme imagemagick
      sudo apt-get install -y libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson
      sudo apt-get install -y libxcb-render-util0-dev libxcb-shape0-dev libxcb-xfixes0-dev i3lock-fancy polybar kitty

      fc-cache -fv

      wget https://github.com/barnumbirr/alacritty-debian/releases/download/v0.10.0-rc4-1/alacritty_0.10.0-rc4-1_amd64_bullseye.deb
      sudo dpkg -i alacritty_0.10.0-rc4-1_amd64_bullseye.deb
      sudo apt install -f

      git clone https://www.github.com/Airblader/i3 i3-gaps
      cd i3-gaps && mkdir -p build && cd build && meson ..
      ninja
      sudo ninja install
      cd ../..

      pip3 install pywal
  else
    echo "What the fuck... it's hard to fucking choose one or two....!!!!!!!!"; check
  fi
  fi
}

check

mkdir -p ~/.local/share/fonts/

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip

unzip Iosevka.zip -d ~/.local/share/fonts/
unzip RobotoMono.zip -d ~/.local/share/fonts/

mkdir ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip
unzip Hack.zip -d ~/.fonts/

mkdir ~/.config
cp -rv config/* ~/.config/
cp -rv seclist ~/
cp -rv bin ~/

cp fehbg ~/.fehbg
cp -rv images ~/.images

chmod +x ~/bin/*
chmod +x ~/.config/bin/*
chmod +x ~/.config/polybar/launch.sh

bash additional_files.sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"








# Check: Q2hlY2tfYWxsX2ltYWdlczogYUhSMGNITTZMeTkzZDNjdVoyOXZaR1p2Ymk1eWRTOWhhUzFoY25RdkNnPT0K
