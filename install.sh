#!/usr/bin/env bash

username=weki

pacman -Syu

pacman -S hyprland xdg-desktop-portal-hyprland qt5-wayland qt6-wayland --noconfirm
pacman -S sddm --noconfirm

systemctl enable sddm.service

cd ~

#yay
git clone https://aur.archlinux.org/yay.git 
cd yay
makepkg -si
cd ~
rm -rf yay

#chaotic-aur setup
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

echo -e "[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | tee -a /etc/pacman.conf
pacman -Sy

#hypr ecosystem
sudo pacman -S hyprpaper hypridle hyprlock hyprcursor nwg-panel --noconfirm
sudo pacman -S alacritty firefox thunar --noconfirm

# shell
sudo pacman -S zsh --noconfirm

#utilities
sudo pacman -S swaync polkit-gnome rofi-wayland waybar cliphist unzip mpv --noconfirm

#theme
sudo pacman -S ttf-jetbrains-mono-nerd font-manager nwg-look qt6-svg qt6-declarative starship --noconfirm

chsh -s $(which zsh) $username

cd desktop-environment

cp grub/grub /etc/default/
cp -r grub/mocha-grub-theme/ /usr/share/grub/themes/
grub-mkconfig -o /boot/grub/grub.cfg

cp sddm/sddm.conf /etc/
cp -r sddm/mocha/ /usr/share/sddm/themes/

cp -r backgrounds/ ~/

cp -r hypr/ ~/.config/

cp -r alacritty/ ~/.config/

cp -r rofi/ ~/.config/

cp -r swaync/ ~/.config/

cp -r waybar/ ~/.config/

cp zsh/.zshrc ~/
cp starship/starship.toml ~/.config/

cp -r THEMES/mocha-cursors /usr/share/icons/
# cp -r THEMES/mocha-icons /usr/share/icons/
cp -r THEMES/index.theme  /usr/share/icons/default/
cp -r THEMES/mocha-gtk /usr/share/themes/

cd ~
rm -rf ~/desktop-environment
