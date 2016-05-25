LIGHT_BLUE='\033[1;34m'
WHITE='\033[1;37m'
LIGHT_RED='\033[1;31m'
NC='\033[0m'

ListeRep="$(find * -type d -prune)"   # liste des repertoires sans leurs sous-repertoires
for Rep in ${ListeRep}; do
	cd ./${Rep}/
	echo -e ${WHITE}---------- ${LIGHT_BLUE}Pulling ${WHITE}repo for${LIGHT_RED} ${Rep} ${WHITE}----------${NC}
	git pull
	cd ..
done
