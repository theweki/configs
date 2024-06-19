#!/usr/bin/env bash

#archinstall - hyprland desktop installed first

sudo pacman -Syu

#archinstall bloat remove
sudo pacman -Rns dunst kitty dolphin wofi --noconfirm

sudo pacman -S hyprland xdg-desktop-portal-hyprland qt5-wayland qt6-wayland --noconfirm
sudo pacman -S sddm --noconfirm
sudo pacman -S pipewire networkmanager xorg-server xorg-xinit --noconfirm
sudo pacman -S intel-media-driver libva-intel-driver vulkan-intel mesa libva-mesa-driver vulkan-radeon xf86-video-amdgpu xf86-video-ati xf86-video-nouveau xf86-video-vmware --noconfirm

systemctl enable sddm.service
systemctl enable NetworkManager.service

# if installed only xorg-server or minimal desktop
# sudo pacman -S hyprland polkit xdg-desktop-portal-hyprland qt5-wayland qt6-wayland dunst kitty dolphin wofi
# sudo pacman -S sddm pipewire networkmanager
# sudo pacman -S intel-media-driver libva-intel-driver vulkan-intel mesa libva-mesa-driver vulkan-radeon xf86-video-amdgpu xf86-video-ati xf86-video-vmware xf86-video-nouveau
# sudo pacman -S xorg-server xorg-xinit

sudo pacman -S git --noconfirm

cd ~

# git clone https://github.com/theweki/desktop-environment.git

#yay
git clone https://aur.archlinux.org/yay.git 
cd yay
makepkg -si 
cd ~
rm -rf yay

#hypr ecosystem
sudo pacman -S hyprpaper hypridle hyprlock hyprcursor nwg-panel --noconfirm
sudo pacman -S alacritty firefox thunar --noconfirm

# shell
sudo pacman -S zsh --noconfirm

#utilities
sudo pacman -S swaync polkit-gnome rofi-wayland waybar cliphist unzip mpv --noconfirm

#bluetooth
sudo pacman -S blueman --noconfirm

#network
sudo pacman -S network-manager-applet --noconfirm

#media
sudo pacman -S pavucontrol --noconfirm

#theme
sudo pacman -S ttf-jetbrains-mono-nerd font-manager nwg-look qt6-svg qt6-declarative starship --noconfirm

#config
systemctl enable bluetooth.service
# systemctl enable NetworkManager.service

chsh -s $(which zsh) $USER

cd desktop-environment

sudo cp grub/grub /etc/default/
sudo cp -r grub/mocha-grub-theme/ /usr/share/grub/themes/
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo cp sddm/sddm.conf /etc/
sudo cp -r sddm/mocha/ /usr/share/sddm/themes/

cp -r backgrounds/ ~/

cp -r hypr/ ~/.config/

cp -r alacritty/ ~/.config/

cp -r rofi/ ~/.config/

cp -r swaync/ ~/.config/

cp -r waybar/ ~/.config/

cp zsh/.zshrc ~/
cp starship/starship.toml ~/.config/

sudo cp -r THEMES/mocha-cursors /usr/share/icons/
# sudo cp -r THEMES/mocha-icons /usr/share/icons/
sudo cp -r THEMES/index.theme  /usr/share/icons/default/
sudo cp -r THEMES/mocha-gtk /usr/share/themes/

cd ~
rm -rf ~/desktop-environment

# MY PACKAGES FOR DEVELOPMENT
# sudo pacman -S github-cli nodejs npm jdk-openjdk docker
# and more ...
