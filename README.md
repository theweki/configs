 # Fedora Post Install Guide
Things to do after installing Fedora

## Faster Updates
* `sudo nano /etc/dnf/dnf.conf` 
* Copy and replace the text with the following:
```
[main] 
gpgcheck=True 
installonly_limit=3 
clean_requirements_on_remove=True 
best=False 
skip_if_unavailable=True 
fastestmirror=True 
max_parallel_downloads=10 
deltarpm=True
defaultyes=True
``` 
## RPM Fusion
* Fedora has disabled the repositories for a lot of free and non-free .rpm packages by default. Follow this if you want to use non-free software like Steam, Discord and some multimedia codecs etc. As a general rule of thumb its advised to do this get access to many mainstream useful programs.
* [ https://rpmfusion.org/Configuration#Command_Line_Setup_using_rpm ]
* `sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm`
* also while you're at it, install app-stream metadata by
* `sudo dnf groupupdate core`

## Update 
* `sudo dnf -y update`
* `sudo dnf -y upgrade --refresh`
* Reboot

## Firmware
* If your system supports firmware update delivery through lvfs, update your device firmware by:
```
sudo fwupdmgr get-devices 
sudo fwupdmgr refresh --force 
sudo fwupdmgr get-updates 
sudo fwupdmgr update
```

## Media Codecs
* Install these to get proper multimedia playback.
````
sudo dnf groupupdate 'core' 'multimedia' 'sound-and-video' --setop='install_weak_deps=False' --exclude='PackageKit-gstreamer-plugin' --allowerasing && sync
sudo dnf swap 'ffmpeg-free' 'ffmpeg' --allowerasing
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia
````

## H/W Video Acceleration
* Helps decrease load on the CPU when watching videos online by alloting the rendering to the dGPU/iGPU. Quite helpful in increasing battery backup on laptops.

### H/W Video Decoding with VA-API 
* `sudo dnf install ffmpeg ffmpeg-libs libva libva-utils`

<details>
<summary>Intel</summary>
 
* If you have an intel chipset after installing the packages above., Do:
* `sudo dnf install intel-media-driver`
</details>

<details>
<summary>AMD</summary>No need to do this for intel integrated graphics. Mesa drivers are for AMD graphics, who lost support for h264/h245 in the fedora repositories in f38 due to legal concerns.
 
* If you have an AMD chipset, after installing the packages above do:
```
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
```
</details>

### OpenH264 for Firefox
* `sudo dnf config-manager --set-enabled fedora-cisco-openh264`
* `sudo dnf install -y openh264 gstreamer1-plugin-openh264 mozilla-openh264`
* After this enable the OpenH264 Plugin in Firefox's settings.

## Update Flatpak ( https://flatpak.org/setup/Fedora )

* `flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo`
* `flatpak update`

  
## Theming [Optional]

* Dracula Environment -> [https://draculatheme.com/] -> GTK, ICON, BROWSER, TERMINAL - all available
* Arctic Nord Environment -> [https://www.nordtheme.com/ports] -> Theme & Icon Not Available (follow third party)


### Use themes in Flatpaks
* `sudo flatpak override --filesystem=$HOME/.themes`
* `sudo flatpak override --env=GTK_THEME=my-theme` 


### Terminal Theme
* Download FireCode Nerd Font (https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.0/FiraCode.zip)
* ZSH Configuration (https://github.com/ohmyzsh/ohmyzsh)
* zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#with-a-plugin-manager)
* zsh-autosuggestion (https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)
* powerlevel10k (https://github.com/romkatv/powerlevel10k#oh-my-zsh)

