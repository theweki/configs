#!/usr/bin/env bash

sudo cp grub/grub /etc/default/
sudo cp -r grub/mocha-grub-theme/ /usr/share/grub/themes/
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo cp sddm/sddm.conf /etc/
sudo cp -r sddm/mocha/ /usr/share/sddm/themes/

sudo cp reflector/reflector.conf /etc/xdg/reflector/

cp -r backgrounds/ ~/

cp -r hypr/ ~/.config/

cp -r alacritty/ ~/.config/

cp -r rofi/ ~/.config/

cp -r swaync/ ~/.config/

cp -r waybar/ ~/.config/

cp zsh/.zshrc ~/
cp starship/starship.toml ~/.config/
