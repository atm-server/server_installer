######## PARAMETRES #############
# $1 => nom du répertoire client
#################################

if [ ! $# == 3 ]; then
	echo "Il faut 3 paramètres pour le nom de l'installation, le mot de passe root mysql et le mot de passe sql futur  (min 20 car. http://www.generateurdemotdepasse.com/)"
	exit 0;
fi

#####################################################################################
# MAJ du dolibarr defaut, des modules ATM génériquet des modules externes de custom
#####################################################################################
cd /home/_default
sh pull_all.sh
cd /home/_default/dolibarr/htdocs/custom
sh pull_all.sh

####################################
# Copie du dolibarr et configuration
####################################
mkdir /home/client/$1
cp -rp /home/_default/* /var/www/client/$1/
cd /var/www/client/$1/dolibarr

sed -i -e "s/url_site/$1/g" /home/client/$1/dolibarr/htdocs/conf/conf.php
sed -i -e "s/root_site/$1/g" /home/client/$1/dolibarr/htdocs/conf/conf.php
sed -i -e "s/defaut_dolibarr/$1_dolibarr/g" /home/client/$1/dolibarr/htdocs/conf/conf.php
sed -i -e "s/mysql_password/$3/g" /home/client/$1/dolibarr/htdocs/conf/conf.php
sed -i -e "s/mysql_user/$1/g" /home/client/$1/dolibarr/htdocs/conf/conf.php

echo "Copie du dolibarr et configuration : OK"

echo "CREATE DATABASE $1_dolibarr" | mysql -u root -p'$2'
echo "CREATE USER '$1'@'localhost' IDENTIFIED BY '$3'" | mysql -u root -p'$2' $1_dolibarr
echo "GRANT ALL PRIVILEGES ON $1_dolibarr . * TO '$1'@'localhost'" | mysql -u root -p'$2' $1_dolibarr

cat /var/www/defaut_dolibarr.sql | mysql -u root -p'$2' $1_dolibarr


echo "Copie base par défaut OK"

###############################################
# Création et initialisation du fichier apache2
###############################################
cd /etc/apache2/sites-available
cp dolibarr_defaut $1
sed -i -e "s/dolibarr_defaut/$1/g" $1 
a2ensite $1
apache2ctl restart
echo "Création et initialisation du fichier apache2 : OK"

echo "Configuration de la sécurité HTTPauth (mot de passe de 4 caractè sur http://www.generateurdemotdepasse.com/ "
htpasswd /var/www/client/.htpasswd $1

################################
# Finalisation de l'installation
################################
cd /var/www/client/$1/dolibarr
touch documents/install.lock
chmod 755 /var/www/client/$1/dolibarr/htdocs/conf/conf.php
echo "Création conf.php et install.lock : OK"

exit 0
