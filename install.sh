#!/usr/bin/env bash

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
# cp -r THEMES/mocha-icons /usr/share/icons/
sudo cp -r THEMES/index.theme  /usr/share/icons/default/
sudo cp -r THEMES/mocha-gtk /usr/share/themes/
