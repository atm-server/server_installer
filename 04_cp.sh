cd ~/server_installer

cp auto_install.sh /var/www/
cp dump-all.sh /home/client/
cp pull_all.sh /home/_default/dolibarr/htdocs/custom/
cp pull_all.sh /home/_default/
cp auto_install.sh /var/www/
cp dolibarr_defaut /etc/apache2/sites-available
cp .htaccess /home/_default/

#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "0	0	*	*	*	/home/client/dump-all.sh" >> mycron
echo "30      12       *       *       *       /home/client/dump-all.sh" >> mycron
#install new cron file
crontab mycron
rm mycron

cd /var/www
ln -s /home/_default
ln -s /home/client
