if [ ! $# == 1 ]; then
        echo "Il faut 1 paramètre pour l'IP du serveur 1"
        exit 0;
fi

echo "$1  atmsrv1" >> /etc/hosts


ssh-keygen
cat ~/.ssh/id_rsa.pub
echo "Il faut ajouter cette clef sur les dépôts"
