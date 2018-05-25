######## PARAMETRES #############
# $1 => nom du serveur
#################################

if [ ! $# == 3 ]; then
	echo "Il faut 3 paramètres pour le nom et le  port du serveur en cours d'installation (ex : srv15 et 8015) et l'adresse de l'intranet (i****.a****.**)"
	exit 0;
fi

echo "$1" > /etc/hostname

cd ~/server_installer

cp auto_install.sh /var/www/
cp dump-all.sh /root/
cp pull_all.sh /home/_default/dolibarr/htdocs/custom/
cp pull_all.sh /home/_default/
cp dolibarr_defaut.conf /etc/apache2/sites-available/
cp .htaccess /home/_default/
cp .htaccess /home/client/
cp .bashrc ~/
cp .bash_aliases ~/
cp .gitconfig ~/

#default conf for Dolibarr default
cp conf.php /home/_default/dolibarr/htdocs/conf/
sed -i -e "s/base_port/$2/g" /home/_default/dolibarr/htdocs/conf/conf.php
sed -i -e "s/base_hostname/$1/g" /etc/apache2/sites-available/dolibarr_defaut.conf

cp sync-monster.sh ~/
sed -i -e "s/intranet_position/$3/g" ~/sync-monster.sh

#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "0	0	*	*	*	/root/dump-all.sh" >> mycron
echo "30      12       *       *       *       /root/dump-all.sh" >> mycron
echo "0	6	*	*	*	/root/sync-monster.sh" >> mycron
#install new cron file
crontab mycron
rm mycron

cd /var/www
ln -s /home/_default
ln -s /home/client
