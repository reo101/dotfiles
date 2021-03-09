#!/usr/bin/env bash

if [[ $(whoami) -ne "root" ]]; then
    echo "Sudo plz :)"
else
    mount /dev/sdb2 /mnt
    mount /dev/sdb1 /mnt/boot
    mount /dev/sdb3 /mnt/shared
fi
