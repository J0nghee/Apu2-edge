# APU2

Apu2 is an evolution of the apu board with a cooler running quad core CPU, more robust Intel NICs, and lower total solution cost.

![Apu2 board](https://pcengines.ch/pic/apu2c2_1.jpg "Apu2 board")



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

- Boot the USB on apu2
- Press down arrow until appears on the screen `Display help screens; type 'menu' at boot prompt to return to this menu" press "enter`
- Write ¨menu¨ and press enter
- Press F6
- after `boot: ` prompt write `install console=ttyS0,115200n8` and press enter
- wait (about 30 seconds)


### Ubuntu (work)

Must download [Ubuntu Alternate](http://cdimage.ubuntu.com/releases/18.04.2/release/?_ga=2.6837746.1317156672.1557303868-755951356.1557213959) (ubuntu-18.04.2-server-amd64, *not* live-server)

Once at the `boot:` prompt type:

install vga=off console=ttyS0,115200n8

### Ubuntu server 18.04 LTS (not working)

Install the .iso on the USB with Unetbootin (iso mode).

Changing file /boot/grub/boot.cfg and replacing `vga=...` with ´console=ttyS0,115200n8´, in theory should work, but it doesn´t.

The file boot.cfg exists only using ISO MODE. 

## Step 2: Automation install of ubuntu/debian

### Preseeding file
Both command and files are the same for ubuntu and debian. 

- Generate the preseed.cfg file. We have 2 different options:
    1. Automatic generate:[Used this](http://debian-handbook.info/browse/stable/sect.automated-installation.html) (not tested)
        `sudo apt-get install debconf-utils`
        `sudo debconf-get-selections --installer`
    2. Modify the [example](https://help.ubuntu.com/lts/installation-guide/example-preseed.txt) founded in the [documentation](https://help.ubuntu.com/lts/installation-guide/amd64/apbs04.html)
        - [Custom preseed file](https://gitlab.fbk.eu/fgionghi/apu2/blob/master/Files/preseed.cfg)

- Turn on the apu2, once at prompt `boot:`, add to command `install vga.. console=..` what´s next:

The best theory situation should be: `install vga=off console=ttyS0m115200n8 url=172.28.48.21:5000/preseed.cfg`

But it doesn work properly, and still ask:

    - language and country. **Solution**: add paramater `locale=en_US.UTF-8`
    - hostname, caused by a [bug](https://bugs.launchpad.net/ubuntu/+source/preseed/+bug/1452202). **Solutions**:
        - add `priority=critical` 
        - add `hostanme=ubuntu`
    - interface, caused by a [bug](https://bugs.launchpad.net/ubuntu/+source/netcfg/+bug/855921). **Solution** add parameter `interface=auto` (or  `interface=enp2s0`) after `url=...`
        
So, the *final command* is: `install vga=off console=ttyS0m115200n8 locale=en_US.UTF-8 url=172.28.48.21:5000/preseed.cfg priority=critical interface=enp2s0 `

## SSH 
[Script finito](https://gitlab.fbk.eu/fgionghi/apu2/blob/master/Files/ssh_script.sh)
The preseed file should run a script that:
    - add to file `~/.ssh/authorized_keys` a public keys
    - change value of PubkeyAuthentication and PasswordAuthentication:
        - change value: sed 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config > temp.txt
        - uncomment and change value: sed 's/#\?\(PubkeyAuthentication\s*\).*$/\1 yes/' /etc/ssh/sshd_config



mv -f temp.txt /etc/ssh/sshd_config

echo ¨chiave pubblica¨ >> ~/.ssh/authorized_keys

Per far partire lo script dal preseeding:
`d-i preseed/run string ssh_script.sh` : da problemi, l´installazione si interrompe dicendo di non poter scaricare né il file né il preseeding
`d-i preseed/late_command string in-target wget -P /tmp/ 172.28.48.21:5000/ssh_script.sh; in-target chmod $+x /tmp/ssh_script.sh; in-target /tmp/ssh_script.sh``