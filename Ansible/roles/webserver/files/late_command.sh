set -x

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

#toglie cancelletto e imposta ¨yes¨
sed 's/#\?\(PasswordAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config > temp.txt

mv -f temp.txt /etc/ssh/sshd_config

sed 's/#\?\(PubkeyAuthentication\s*\).*$/\1 yes/' /etc/ssh/sshd_config > temp.txt

mv -f temp.txt /etc/ssh/sshd_config

if [ ! -d "/home/user/.ssh" ]
then
	mkdir /home/user/.ssh
	chmod 700 /home/user/.ssh
	touch /home/user/.ssh/authorized_keys
	chmod 600 /home/user/.ssh/authorized_keys
	chown -R user /home/user/.ssh 
fi

echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9/OTBrvWK/hgl8tThoWEDbSnvJU7RKcGty5jXpR52dQC10H0BGYi2OiNi5oG65H2AWAmz6bVM59XM1Q/F/Rvo/Xqjc7Zw+nkUMQTYEq1ip670ltjHwhNgVRCZaGiLgyJx0KBijxYnYiR7epYafFpatRqjdWN7AHCKV/pBPbHjXd4qs45po1FMsOQj0XWSiQJegeZUbShXuK7Mows3EcCCA19y+QNhdyctKFXwMrmuI35gIQROAkoWq9yjvJmgub6M7Mo4RFLiRTG8fnVXAVwEiVpalMiXFQr81IxnvjEOS70YFpH5PQxwMpZNU2vDzz9qg3rCq+aSw7usu9okvCaX gionghi@Latitude-E5440 >> /home/user/.ssh/authorized_keys

chown -R user /home/user/.ssh 

systemctl restart sshd
