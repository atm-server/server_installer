#!/bin/bash

BLUE='\033[1;34m'
WHITE='\033[1;37m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'


################
# Uncomment if you want the script to always use the scripts
# directory as the folder to look through
#REPOSITORIES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPOSITORIES=`pwd`
remote=origin

## Liste des modules à exclure des checkout
declare -A TModuleExclude=(
	[abricot]=1 [agefodd]=1
)

for REPO in `ls "$REPOSITORIES/"`
do
    lastversionstable=0
    
    if [[ -n "${TModuleExclude[$REPO]}" ]]; then
		continue
	fi
    
    if [ -d "$REPOSITORIES/$REPO" ]
    then
        echo -e "${BLUE}Updating folder ${WHITE}$REPOSITORIES/$REPO${RED} at `date`${NC}"
        if [ -d "$REPOSITORIES/$REPO/.git" ]
        then
            cd "$REPOSITORIES/$REPO"
            for brname in `
                git branch -r | grep $remote | grep -v master | grep -v HEAD | awk '{gsub(/[^\/]+\//,"",$1); print $1}'
                `; do

                if [[ $brname =~ ^[1-9][0-9]*\.0$ ]]; then

                    IFS='.' read -r -a tabversion <<< "$brname"
                    number=${tabversion[0]}

                    if [ $number -gt $lastversionstable ]; then
                        lastversionstable=$number
                    fi
                fi

            done

            if [ $lastversionstable -ne 0 ]; then
                echo -e "${WHITE}git branch $lastversionstable.0${NC}"
                git branch $lastversionstable.0

                #echo -e "${WHITE}git checkout $remote $lastversionstable.0${NC}"
                #git checkout $remote $lastversionstable.0
				echo -e "${WHITE}git checkout $lastversionstable.0${NC}"
                git checkout $lastversionstable.0

                echo -e "${WHITE}git pull $remote $lastversionstable.0${NC}"
                git pull $remote $lastversionstable.0

                echo -e "${WHITE}git reset --hard $remote/$lastversionstable.0${NC}"
                git reset --hard $remote/$lastversionstable.0
            fi

        else
            echo -e "${YELLOW}Skipping because it doesn't look like it has a .git folder.${NC}"
        fi
        echo "Done at `date`"

    fi
done
