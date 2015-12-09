mysqldump -u root -p defaut_dolibarr > /var/www/defaut_dolibarr.sql
tar -zcvf d.tar  /var/www/defaut_dolibarr.sql
openssl aes-256-cbc -in d.tar -out d.enc
rm d.tar
