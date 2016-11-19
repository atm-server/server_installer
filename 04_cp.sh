######## PARAMETRES #############
# $1 => nom du serveur
#################################

if [ ! $# == 1 ]; then
	echo "Il faut 1 paramètres pour le nom du serveur en cours d'installation (ex : srv1)"
	exit 0;
fi

echo "$1" > /etc/hostname

cd ~/server_installer

cp auto_install.sh /var/www/
cp dump-all.sh /root/
cp pull_all.sh /home/_default/dolibarr/htdocs/custom/
cp pull_all.sh /home/_default/
cp dolibarr_defaut /etc/apache2/sites-available
cp .htaccess /home/_default/
cp .htaccess /home/client/
cp .bashrc ~/
cp .bash_aliases ~/
cp .gitconfig ~/

#default conf for Dolibarr default
cp conf.php /home/_default/dolibarr/htdocs/conf/
sed -i -e "s/base_hostname/$1/g" /home/_default/dolibarr/htdocs/conf/conf.php

#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "0	0	*	*	*	/root/dump-all.sh" >> mycron
echo "30      12       *       *       *       /root/dump-all.sh" >> mycron
#install new cron file
crontab mycron
rm mycron

cd /var/www
ln -s /home/_default
ln -s /home/client
