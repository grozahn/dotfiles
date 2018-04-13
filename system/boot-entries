#!/usr/bin/env bash

if [[ $(id -u) -eq 0 ]]; then
    echo -n 'Enter number of root partition: '
    read PART
    
    efibootmgr --disk /dev/sda1 --part 1 --create --gpt --label "Arch Linux" --loader /arch/vmlinuz-linux --unicode "root=/dev/sda$PART rw queit loglevel=3 rd.systemd.show_status=auto rd.udev.log-priority=3 splash initrd=/arch/initramfs-linux.img /arch/intel-ucode.img"
    efibootmgr --disk /dev/sda1 --part 1 --create --gpt --label "Arch Linux (Recovery)" --loader /arch/vmlinuz-linux --unicode "root=/dev/sda$PART rw single initrd=/arch/initramfs-linux-fallback.img"
else
    echo 'Run script with root privileges'
fi 

