#!/usr/bin/env bash

# mbr partitioning with 2GiB swap
parted /dev/sda -- mklabel msdos
parted /dev/sda -- mkpart primary 1MiB -2GiB
parted /dev/sda -- mkpart primary linux-swap -2GiB 100%

mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
swapon /dev/sda2
mount /dev/disk/by-label/nixos /mnt

# base install
nixos-generate-config --root /mnt
mv /mnt/etc/nixos/* /home/nixos/
rmdir /mnt/etc/nixos
git clone --recurse-submodules https://github.com/morepheus/nixfiles.git /mnt/etc/nixos
