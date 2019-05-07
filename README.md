# APU2

How to install a linux distro on apu2

## Debian with Unetbootin (iso mode)


https://syscall.eu/blog/2017/07/19/apu/ ha funzionato
- Far partire la USB
- Premere freccia giú finche non compare la scritta `Display help screens; type 'menu' at boot prompt to return to this menu" press "enter`
- Scrivere ¨menu¨ e premere invio
- premere F6
- dopo `boot: ` scrivere `install console=ttyS0,115200n8` e premere invio
- aspettare

## Debian with dd



## Ubuntu 18.04 with dd

`sudo dd if=Downloads/ubuntu-18.04.2-live-server-amd64.iso of=/dev/sdc status=progress`




