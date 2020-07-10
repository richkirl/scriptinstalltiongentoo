#!/bin/sh

env-update && source /etc/profile

export PS1="[chroot] $PS1"

emerge-webrsync

emerge -avuDN @world

echo "Europe/Moscow" > /etc/timezone

emerge --config sys-libs/timezone-data

echo '/dev/sda6               /               ext4            defaults,noatime         0 1' >> /etc/fstab

echo '/dev/sda4              /boot/EFI           vfat            defaults         0 0' >> /etc/fstab

echo '/dev/sda5               none            swap            sw              0 0' >> /etc/fstab

emerge -a gentoo-sources

emerge -a pciutils usbutils

mkdir /etc/portage/package.license

echo "sys-kernel/linux-firmware linux-fw-redistributable no-source-code" >> /etc/portage/package.license/custom

cd /usr/src/linux

make mrproper

make menuconfig

make -j9

make modules_install

make install

emerge -a dhcpcd

passwd

useradd -m -G users,wheel,audio,cdrom,video,portage -s /bin/bash jimmy

passwd jimmy

echo 'GRUB_PLATFORMS="pc efi-64"' >> /etc/portage/make.conf

emerge -a grub

grub-install --target=x86_64-efi --efi-directory=/boot/EFI

grub-mkconfig -o /boot/grub/grub.cfg

exit
rm -f /mnt/gentoo/*tar.xz

cd /

umount -R /mnt/gentoo
