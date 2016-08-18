mysqldump -u root -p defaut_dolibarr > /var/www/defaut_dolibarr.sql
cd /var/www/
tar -zcvf ~/server_installer/d.tar defaut_dolibarr.sql
cd ~/server_installer
openssl aes-256-cbc -in d.tar -out d.enc
rm d.tar