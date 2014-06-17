######## PARAMETRES #############
# $1 => nom du répertoire client
#################################

if [ ! $# == 1 ]; then
	echo "Il faut 1 paramètre pour le nom de l'installation"
	exit 0;
fi

#####################################################################################
# MAJ du dolibarr defaut, des modules ATM génériquet des modules externes de custom
#####################################################################################
sh pull_all.sh /home/_default
sh pull_all.sh /home/_default/dolibarr/htdocs/custom

####################################
# Copie du dolibarr et configuration
####################################
cp -r /home/_default /var/www/client/$1
cd /var/www/client/$1/dolibarr
mkdir documents
chmod 777 documents
touch htdocs/conf/conf.php
chmod 777 htdocs/conf/conf.php
echo "Copie du dolibarr et configuration : OK"

###############################################
# Création et initialisation du fichier apache2
###############################################
cd /etc/apache2/sites-available
cp dolibarr_defaut $1
sed -i -e "s/dolibarr_defaut/$1/g" $1 
a2ensite $1
apache2ctl restart
echo "Création et initialisation du fichier apache2 : OK"

##########################################################
# Mise en pause du script pour installation via navigateur
##########################################################
echo "Installation par navigateur maintenant nécessaire, appuyez sur une touche pour lancer la suite du script"
read touche
echo "Reprise du script"

echo "Configuration de la sécurité HTTPauth (mot de passe de 4 caractè sur http://www.generateurdemotdepasse.com/ "
htpasswd /var/www/client/.htpasswd $1

################################
# Finalisation de l'installation
################################
cd /var/www/client/$1/dolibarr
touch documents/install.lock
chmod 755 /var/www/client/$1/dolibarr/htdocs/conf/conf.php
echo "Création conf.php et install.lock : OK"

###################################################################
# Activation du répertoire custom et création des liens symboliques
###################################################################
cd /var/www/client/$1/dolibarr/htdocs/conf/
sed -i -e 's/\/\/$dolibarr_main_url_root_alt/$dolibarr_main_url_root_alt/g' conf.php
sed -i -e 's/\/\/$dolibarr_main_document_root_alt/$dolibarr_main_document_root_alt/g' conf.php
cd ../
#mkdir custom
cd custom
ln -s /var/www/client/$1/doli-report report
#ln -s /var/www/client/$1/doli-export-compta export-compta
#ln -s /var/www/client/$1/doli-caisse caisse
echo "Activation répertoire custom + liens symboliques : OK"


exit 0
