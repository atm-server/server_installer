#!/bin/bash
exit
#commenter exit pour vraiment mettre ce truc en place c'est dangerous !
#export LANG=en_us_8859_1
cd /home/client
echo 'Extraction...'
tar xzf database_`date +"%a-00"`.sql.tar.bz2
echo 'Chargement...'
mysql -uroot -p'root_password' < database_`date +"%a-00"`.sql
echo 'Fin...'
## Suppression des exports non compresses
rm database_`date +"%a-00"`.sql
rm database_`date +"%a-00"`.sql.tar.bz2


