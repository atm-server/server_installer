WHITE='\033[1;37m'
LIGHT_RED='\033[1;31m'
NC='\033[0m'
ListeRep="$(find * -type d -prune)"   # liste des repertoires sans leurs sous-repertoires
for Rep in ${ListeRep}; do
      
#	echo ${Rep}
	cd ${Rep}
	if [ -d ".git" ]; then
		echo -e "${WHITE} ${Rep} - ${LIGHT_RED} $(git rev-parse --abbrev-ref HEAD) ${NC}"
	fi
	cd ..

done
