#!/bin/bash

cd /home/client

rm database_`date +"%a-%H"`.sql.tar.bz2 

mysqldump -uroot --password="your-db-password" --all-databases --add-drop-table > database_`date +"%a-%H"`.sql

tar jcf database_`date +"%a-%H"`.sql.tar.bz2 database_`date +"%a-%H"`.sql

## Suppression des exports non compresses
rm database_`date +"%a-%H"`.sql

