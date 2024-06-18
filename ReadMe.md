# Installation

# GRUB
    sudo cp grub/grub /etc/default/
    sudo cp -r grub/mocha-grub-theme/ /usr/share/grub/themes/
    sudo grub-mkconfig -o /boot/grub/grub.cfg

# SDDM
    sudo pacman -Syu qt6-svg qt6-declarative
    sudo cp sddm/sddm.conf /etc/
    sudo cp -r sddm/mocha/ /usr/share/sddm/themes/

# BACKGROUNDS
    cp -r backgrounds/ ~/

# HYPRLAND
    cp -r hypr/ ~/.config/

# ALACRITTY
    sudo pacman -S starship
    cp -r alacritty/ ~/.config/

# ROFI
    cp -r rofi/ ~/.config/

# SWAYNC
    cp -r swaync/ ~/.config/

# WAYBAR
    cp -r waybar/ ~/.config/

# THEME