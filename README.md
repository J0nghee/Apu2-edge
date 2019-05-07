# APU2

How to install a linux distro on apu2

## Debian with Unetbootin (iso mode)

in boot/grub/boot.cfg, sostituire vga=... con linux console=ttyS0,115200n8
/install.amd/vmlinuz console=ttyS0,115200n8 --- quiet

https://syscall.eu/blog/2017/07/19/apu/ funzionato
pass: edge123

## Debian with dd



## Ubuntu 18.04 with dd

`sudo dd if=Downloads/ubuntu-18.04.2-live-server-amd64.iso of=/dev/sdc status=progress`




