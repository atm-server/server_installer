wget -O monster.txt https://intranet_position/custom/passgenrator/monster.txt
value=`cat monster.txt`
echo ";$value;"
htpasswd -b /home/client/.htpasswd atm $value
rm monster.txt

