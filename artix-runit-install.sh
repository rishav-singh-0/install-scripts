#!/bin/sh

#############################
# basestrap /mnt base base-devel runit elogind-runit linux-lts linux-firmware vim
# fstabgen -U /mnt >> /mnt/etc/fstab
# artix-chroot /mnt
#############################


ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo 'export LANG="en_US.UTF-8"' > /etc/locale.conf
echo 'export LC_COLLATE="C"' > /etc/locale.conf
echo 'artix' > /etc/hostname
echo '127.0.0.1   localhost' >> /etc/hosts
echo '::1         localhost' >> /etc/hosts
echo '127.0.1.1   artix.localdomain  artix' >> /etc/hosts

password='l'
echo root:$password | chpasswd

pacman -S grub os-prober efibootmgr 
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -P

user='rishav'
useradd -mG wheel,audio,video $user
echo $user:$password | chpasswd

pacman -S dhcpcd
# pacman -S connman-runit networkmanager
# ln -s /etc/runit/sv/connmand /etc/runit/runsvdir/default
