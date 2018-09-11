if [ ! $# == 1 ]; then
	echo "Veuillez saisir en paramètre le nom de l'install à désactiver"
	exit 0;
fi

if [ ! -d "/home/client/$1" ]; then
	echo "Répertoir /home/client/$1 introuvable"
	exit 0;
fi

if [ ! -f "/etc/apache2/sites-available/$1.conf" ]; then
	echo "Fichier /etc/apache2/sites-available/$1.conf introuvable, impossible de désactiver ce site"
	exit 0;
fi

if [ ! -f "/etc/apache2/sites-available/$1-le-ssl.conf" ]; then
	echo "Fichier /etc/apache2/sites-available/$1-le-ssl.conf introuvable, impossible de désactiver ce site"
	exit 0;
fi

a2dissite $1.conf
a2dissite $1-le-ssl.conf

echo "**************************"
echo "commamdes à exécuter manuellement si suppression et seulement si les sites sont bien désactivés :"

echo "rm -rf /home/client/$1"
echo "rm -f /etc/apache2/sites-available/$1.conf"
echo "rm -f /etc/apache2/sites-available/$1-le-ssl.conf"

echo "htpasswd -D /home/client/.htpasswd $1"

echo "DROP DATABASE $1_dolibarr" 


#LIVEKEYSFOLDER=$(find /etc/letsencrypt/live/ -name "$1.*" -type d)
#if [ ! -z $LIVEKEYSFOLDER ]; then
#	echo "Dossier $LIVEKEYSFOLDER trouvé, à rm si suppression"
#fi

#ARCHIVEKEYSFOLDER=$(find /etc/letsencrypt/archive/ -name "$1.*" -type d)
#if [ ! -z $ARCHIVEKEYSFOLDER ]; then
#	echo "Dossier $ARCHIVEKEYSFOLDER trouvé, à rm si suppression"
#fi

#RENEWALKEYSFOLDER=$(find /etc/letsencrypt/live/ -name "$1.*" -type d)
#if [ ! -z $RENEWALKEYSFOLDER ]; then
#	echo "Dossier $RENEWALKEYSFOLDER trouvé, à rm si suppression"
#fi
