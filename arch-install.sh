#!/bin/sh

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
echo 'arch' > /etc/hostname
echo '127.0.0.1   localhost' >> /etc/hosts
echo '::1         localhost' >> /etc/hosts
echo '127.0.1.1   arch.localdomain  arch' >> /etc/hosts

password='l'
echo root:$password | chpasswd

pacman -S --noconfirm grub efibootmgr os-prober git networkmanager network-manager-applet man-db bash-completion zsh zsh-completions
pacman -S --noconfirm libx11 xorg-xinit libxinerama libxft xorg-server xorg-xrandr xorg-xrdb xorg-xinput xorg-xbacklight xclip picom unclutter
# pacman -S --noconfirm nvidia-lts nvidia-utils nvidia-settings nvidia-prime
pacman -S --noconfirm xf86-video-intel

pacman -S alsa-utils pipewire pipewire-alsa pipewire-pulse pulsemixer pamixer
pacman -S fd ripgrep fzf htop nitrogen ranger pcmanfm dunst libnotify xarchiver xterm evince sxiv ueberzug maim atool zip unzip tar bzip2 gzip lzip unrar neofetch tlp powertop
pacman -S --noconfirm noto-fonts ttf-joypixels
# pacman -S --noconfirm bluez bluez-utils

user='rishav'
useradd -mG wheel,audio,video $user
echo $user:$password | chpasswd
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -P

systemctl enable NetworkManager
systemctl enable tlp
# systemctl enable bluetooth

