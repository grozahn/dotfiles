#!/usr/bin/env bash

while [[ -d "/proc/$PPID" ]]; do
	sleep 1
done

/usr/bin/cp -f /boot/vmlinuz-linux /boot/efi/arch/vmlinuz-linux
/usr/bin/cp -f /boot/initramfs-linux.img /boot/efi/arch/initramfs-linux.img
/usr/bin/cp -f /boot/initramfs-linux-fallback.img /boot/efi/arch/initramfs-linux-fallback.img
/usr/bin/cp -f /boot/intel-ucode.img /boot/efi/arch/intel-ucode.img

echo "Synced kernel with ESP"
