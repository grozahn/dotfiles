#!/bin/bash

if [[ $(id -u) -eq 0 ]]; then
    echo -n 'Enter number of root partition: '
    read PART

    # Arch Linux (Silent) Boot Entry
    efibootmgr --disk /dev/sda1 --part 1 --create --gpt --label "Arch Linux" \
        --loader /arch/vmlinuz-linux \
        --unicode "root=/dev/sda$PART rw elevator=noop quiet loglevel=3 rd.systemd.show_status=false rd.udev.log_priority=3 vt.global_cursor_default=0 splash i915.fastboot=1 initrd=/arch/initramfs-linux.img /arch/intel-ucode.img"

    # Arch Linux (Verbose) Boot Entry
    efibootmgr --disk /dev/sda1 --part 1 --create --gpt --label "Arch Linux (Recovery)" \
        --loader /arch/vmlinuz-linux \
        --unicode "root=/dev/sda$PART rw elevator=noop single initrd=/arch/initramfs-linux-fallback.img /arch/intel-ucode.img"

    # Arch Linux (Recovery) Boot Entry
    efibootmgr --disk /dev/sda1 --part 1 --create --gpt --label "Arch Linux (Recovery)" \
        --loader /arch/vmlinuz-linux \
        --unicode "root=/dev/sda$PART ro elevator=noop single initrd=/arch/initramfs-linux-fallback.img"
else
    echo 'Run script with root privileges'
fi 

