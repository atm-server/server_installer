cd ~/server_installer

openssl aes-256-cbc -d -in k.enc | tar xz
mkdir /home/ssl-cert
mv srv8.atm-consulting.fr.* /home/ssl-cert/

