# Prerequisite
    yay -S sddm
    systemctl enable sddm.service
    sudo reboot

yay -S [your-sddm-theme]

sudo mkdir /etc/sddm.conf.d

sudo cp sddm/sddm.conf /etc/sddm.conf.d/

sudo cp [/path/to/your/wallpaper.png] /usr/share/sddm/themes/[your-sddm-theme]/Backgrounds/current_wallpaper.png

sudo cp sddm/theme.conf /usr/share/sddm/themes/[your-sddm-theme]/

~~sudo sed -i 's/CURRENTWALLPAPER/'"current_wallpaper.jpg"'/' /usr/share/sddm/themes/sugar-candy/theme.conf~~
