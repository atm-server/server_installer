cd ~/server_installer

cp auto_install.sh /var/www/
cp dump-all.sh /root/
cp pull_all.sh /home/_default/dynamicrh/htdocs/custom/
cp pull_all.sh /home/_default/
cp auto_install.sh /var/www/
cp dolibarr_defaut /etc/apache2/sites-available
cp .htaccess /home/_default/
cp .htaccess /home/client/

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
