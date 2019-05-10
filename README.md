# APU2

Mac address:
- black: 
    - wifi: 04F021457CA4
    - enp2s0:
    - ..
    - ..
- blue:  
    - wifi: 04F021457CA2
- red:   
    - wifi: 04F021457CA5



## Step 1: Install a linux distro on apu2 ( [Offical documentation](https://pcengines.ch/howto.htm#home) )

### Debian (work)

[Guida utilizzata](https://syscall.eu/blog/2017/07/19/apu/)

- Far partire la USB sulla apu
- Premere freccia giú finche non compare la scritta `Display help screens; type 'menu' at boot prompt to return to this menu" press "enter`
- Scrivere ¨menu¨ e premere invio
- premere F6
- dopo `boot: ` scrivere `install console=ttyS0,115200n8` e premere invio
- aspettare


### Ubuntu (work)

Must download [Ubuntu Alternate](http://cdimage.ubuntu.com/releases/18.04.2/release/?_ga=2.6837746.1317156672.1557303868-755951356.1557213959) (ubuntu-18.04.2-server-amd64, *not* live-server)

Once at the "boot:" prompt type:

install vga=off console=ttyS0,115200n8

### Ubuntu server 18.04 LTS (not working)

Install the .iso on the USB with Unetbootin (iso mode).

Cambiando il file /boot/grub/boot.cfg e sostiuendo al post di `vga=...` -> ´console=ttyS0,115200n8´, in teoria si dovrebbe riuscire ma invece no. 

Il file boot.cfg c´é solo masterizzando la iso in ISO MODE. 

## Step 2: Preseeding 

### Preseeding with ubuntu/debian
Sia il file che i comandi utilizzati sono gli stessi per ubuntu e debian. 

- Generate the preseed.cfg file. We have 2 different options
    1. Automatic generate:[Used this](http://debian-handbook.info/browse/stable/sect.automated-installation.html)
    
        `sudo apt-get install debconf-utils`
        `sudo debconf-get-selections --installer`
    2. Modify the [example](https://help.ubuntu.com/lts/installation-guide/example-preseed.txt) founded in the [documentation](https://help.ubuntu.com/lts/installation-guide/amd64/apbs04.html)
        - [file preseed modificato](https://gitlab.fbk.eu/fgionghi/apu2/blob/master/Files/preseed.cfg)

- Avviare la scheda, una volta arrivati al prompt `boot:`, proseguire il comando `install vga.. console=..` come descritto in seguito

L´ideale sarebbe poter scrivere `install vga=off console=ttyS0m115200n8 url=172.28.48.21:5000/preseed.cfg`

Peró vengono comunque chiesti alcuni valori:

    - lingua: aggiungere il paramentro locale=en_US.UTF-8
    - hostname, a causa di un [bug](https://bugs.launchpad.net/ubuntu/+source/preseed/+bug/1452202). Soluzioni:
        - aggiungere `priority=critical` come paramentro da passare al boot
        - aggiungere hostanme=ubuntu come paramentro da passare al boot
    - interface, a causa di un [bug](https://bugs.launchpad.net/ubuntu/+source/netcfg/+bug/855921). Soluzione:
        - aggiungere paramentro interface=enp2s0 dopo `url=...`
        
Il comando finale diventa quindi: `install vga=off console=ttyS0m115200n8 locale=en_US.UTF-8 url=172.28.48.21:5000/preseed.cfg priority=critical interface=enp2s0 `

## SSH 
[Script finito](https://gitlab.fbk.eu/fgionghi/apu2/blob/master/Files/ssh_script.sh)
Scopo: script che aggiunga al file ~/.ssh/authorized_keys una chiave pubblica e modifichi i parametri PubkeyAuthentication e PasswordAuthentication

cambia valore: sed 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config > temp.txt
toglie cancelletto e cambia valore: sed 's/#\?\(PubkeyAuthentication\s*\).*$/\1 yes/' /etc/ssh/sshd_config

mv -f temp.txt /etc/ssh/sshd_config

echo ¨chiave pubblica¨ >> ~/.ssh/authorized_keys
