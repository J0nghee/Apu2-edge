#toglie cancelletto e imposta ¨yes¨
sed 's/#\?\(PasswordAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config
mv -f temp.txt /etc/ssh/sshd_config

sed 's/PubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config > temp.txt
mv -f temp.txt /etc/ssh/sshd_config

echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5WDt795bDdD+jxDwbEKoqamV653VI90g+BTBDMnYVU/MzCGbHqAQ3K+/Mc9xlF4VG+cL/lA7DuL8+zq8/ig64fbHUz9zhwTT9vdfivTCQM77IYFvDp8vLolOuR2JD3Kd5RuJpfmiI8bMutzFSDPAVV31xg0zRl4pXBoou9gZeU17VwcrAAWt6+7ckHIme8aTGvtepKpLPaN81u+w62h9RqraDFNpFjf6GWDYYSD0ixJsO7Wnez6mZ87W2qqO1ml9oubUJBYZ2spWzpKpAB+rM9Tw+XCK0lu9P/tXDkcq9k4EtE/eWUUTdiFLoJP5ZCULFWnIF8NzEM6St6wPGLR2h gionghi@Latitude-E5440 >> ~/.ssh/authorized_keys