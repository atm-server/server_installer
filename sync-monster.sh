wget -O monster.txt http://intranet_position/custom/passgenrator/monster.txt
value=`cat monster.txt`
echo ";$value;"
htpasswd -b /home/client/.htpasswd atm $value
rm monster.txt

/home/ssl-cert/certbot-auto renew --quiet --no-self-upgrade
