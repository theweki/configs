# connect to internet
# format disk using gdisk
# create partition - efi(1GB)[EFI File System], swap(8GB) [SWAP], root(btrfs) [Linux File System] (Remaining) using cfdisk

# for hidpi -> setfont ter-132b

# loadkeys us

pacman -Syy

timedatectl set-ntp true

lsblk
# READ Partitions Here For EFI, SWAP, ROOT

read -p "EFI Partition e.g., nvme0n1p1: " EFI
read -p "SWAP Partition e.g., nvme0n1p2: " SWAP
read -p "Root Partition e.g., nvme0n1p3: " ROOT

keyboardlayout="us"
zoneinfo="Asia/Kolkata"
hostname="localhost"
username="weki"

mkfs.fat -F 32 /dev/$EFI
mkswap /dev/$SWAP
mkfs.btrfs -f /dev/$ROOT

mount /dev/$ROOT /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
umount /mnt

mount -o compress=zstd:1,noatime,subvol=@ /dev/$ROOT /mnt

mkdir /mnt/home
mount -o compress=zstd:1,noatime,subvol=@home /dev/$ROOT /mnt/home

mkdir -p /mnt/boot/efi
mount /dev/$EFI /mnt/boot/efi

swapon /dev/$SWAP

pacstrap -K /mnt base base-devel linux linux-firmware intel-ucode amd-ucode btrfs-progs

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/$zoneinfo /etc/localtime
hwclock --systohc

pacman --noconfirm -S reflector

reflector -c "India," -p https -a 3 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy

pacman --noconfirm -S grub efibootmgr linux-headers grub-btrfs sof-firmware wireplumber pipewire pipewire-alsa pipewire-jack pipewire-pulse networkmanager network-manager-applet wireless_tools wpa_supplicant dialog cups bluez bluez-utils bluez-cups blueman nano vim openssh htop wget xdg-utils rsync xorg-server xorg-xinit git

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

echo "KEYMAP=$keyboardlayout" >> /etc/vconsole.conf

echo "$hostname" >> /etc/hostname

echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $hostname.localdomain $hostname" >> /etc/hosts

echo "Set Root Password"
passwd root

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

useradd -m -G wheel $username
echo "Enter User Password: "
passwd $username

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable fstrim.timer

# sed -i 's/BINARIES=()/BINARIES=(btrfs setfont)/g' /etc/mkinitcpio.conf
# mkinitcpio -p linux

echo "Uncomment %wheel group in sudoers (around line 85):"
echo "Before: #%wheel ALL=(ALL:ALL) ALL"
echo "After:  %wheel ALL=(ALL:ALL) ALL"
echo ""
read -p "Open sudoers now?" c
EDITOR=vim sudo -E visudo

usermod -aG wheel weki

exit
umount -R /mnt
