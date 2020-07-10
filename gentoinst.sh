#!/bin/sh


fsroot='/dev/sda6'

fsboot='/dev/sda4'

mntgentoo='/mnt/gentoo'

mntswapgent='/dev/sda5'

mntbootgentoo='/mnt/gentoo/boot/EFI'


mkfs.fat -F32 $fsboot

mkfs.ext4 $fsroot

mkswap $mntswapgent

swapon $mntswapgent


mkdir $mntgentoo

mount $fsroot $mntgentoo

mkdir -p $mntbootgentoo

mount $fsroot $mntbootgentoo

cd $mntgentoo

echo copy next link paste to browser and select stage3 tar and copy adress for stage3 and paste link to stage3 in console for download stage3*tar.xz http://gentoo.osuosl.org/releases/amd64/autobuilds/current-stage3-amd64/

read download

wget -4 $download

tar xJvpf stage3-*.tar.xz

echo 'USE="python"' >> /mnt/gentoo/etc/portage/make.conf

echo 'MAKEOPTS="-j9"' >> /mnt/gentoo/etc/portage/make.conf

echo 'LINGUAS="ru"' >> /mnt/gentoo/etc/portage/make.conf

echo 'L10N="ru"' >> /mnt/gentoo/etc/portage/make.conf

echo 'VIDEO_CARDS="intel i915 nouveau"' >> /mnt/gentoo/etc/portage/make.conf

echo 'INPUT_DEVICES="libinput synaptics keyboard mouse evdev"' >> /mnt/gentoo/etc/portage/make.conf

echo 'EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --quiet-build=y"' >> /mnt/gentoo/etc/portage/make.conf

mkdir -p /mnt/gentoo/etc/portage/repos.conf

cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf

cp -L /etc/resolv.conf /mnt/gentoo/etc/

mount -t proc /proc $mntgentoo/proc
mount --rbind /dev $mntgentoo/dev
mount --rbind /sys $mntgentoo/sys

chroot $mntgentoo /bin/bash
