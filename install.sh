#!/usr/bin/env bash

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
