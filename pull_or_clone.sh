MODULE_NAME="serverobserver" ## nom du module à déployer
DIR_CLIENT="/home/client" ## répertoir de base d'installation des clients

cd $DIR_CLIENT

ListeRep="$(find * -type d -prune)"   # liste des repertoires sans leurs sous-repertoires

for Rep in ${ListeRep}; do
	if [ -d "./${Rep}/dolibarr/htdocs/custom/${MODULE_NAME}" ]
	then
		cd ./${Rep}/dolibarr/htdocs/custom/${MODULE_NAME}
		echo "$Rep"
		git log -1 --format=%cd --date=short
		git pull origin master
		echo "-----------"
	else 
		echo "not installed $Rep"
		if [ -d "./${Rep}/dolibarr/htdocs/custom" ]
		then
			cd ./${Rep}/dolibarr/htdocs/custom
			git clone git@github.com:ATM-Consulting/dolibarr_module_$MODULE_NAME.git $MODULE_NAME
		else
			echo "IMPOSSIBLE DE CLONER ${MODULE_NAME} DANS LE DOSSIER ${Rep}/dolibarr/htdocs/custom CAR NON EXISTANT"
			#mkdir -p ./${Rep}/dolibarr/htdocs/custom ## si nécessité de créer le répertoir custom
		fi
	fi

	cd $DIR_CLIENT
done
