#!/bin/bash

LBLUE='\033[1;34m'
WHITE='\033[1;37m'
LRED='\033[1;31m'
LPURPLE='\033[1;35m'
NC='\033[0m'

# ###########################################################
# #################### TODO explode file ####################
# ###########################################################

printf "\n${LPURPLE}"
printf "######################\n"
printf "# Deploying bash files\n"
printf "######################\n"
printf "${NC}"

read -p "Deploy .bashrc file in ~ ? (y/N) " DEP_BASHRC
if [ "$DEP_BASHRC" = "y" ]; then
    printf "${WHITE}cp .bashrc ~/${NC}\n"
    cp .bashrc ~/
    source ~/.bashrc                # reload file
fi

read -p "Deploy .bash_aliases file in ~ ? (y/N) " DEP_BASH_ALIASES
if [ "$DEP_BASH_ALIASES" = "y" ]; then
    printf "${WHITE}cp .bash_aliases ~/${NC}\n"
    cp .bash_aliases ~/
fi

read -p "Deploy .gitconfig file in ~ ? (y/N) " DEP_GITCONFIG
if [ "$DEP_GITCONFIG" = "y" ]; then
    printf "${WHITE}cp .gitconfig ~/${NC}\n"
    cp .gitconfig ~/
fi

# #######################################################################


printf "\n${LPURPLE}"
printf "###########################\n"
printf "## Select installation type\n"
printf "###########################\n"
printf "${NC}"

OS=''
VER=''
if [ -f /etc/os-release ]; then
    source /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
fi

if [ "$OS" = "Debian GNU/Linux" ] && [ "$VER" -le "7" ]; then
    INSTALL_TYPE_DEFAULT=1
else
    INSTALL_TYPE_DEFAULT=2
fi

while :
do
    echo "Installation type:"
    echo "[1] - Debian <= 7 with php5 mysql5.6"
    echo "[2] - Debian >= 8 with php mariadb"
    read -p "1,2 [$INSTALL_TYPE_DEFAULT]: " INSTALL_TYPE_SELECTED

    if [ "$INSTALL_TYPE_SELECTED" = "1" ] || [ "$INSTALL_TYPE_SELECTED" = "2" ]; then
        break;
    elif [ -z "$INSTALL_TYPE_SELECTED" ]; then
        INSTALL_TYPE_SELECTED=$INSTALL_TYPE_DEFAULT
        break;
    fi
done

# #######################################################################


printf "\n${LPURPLE}"
printf "###################\n"
printf "## Install packages\n"
printf "###################\n"
printf "${NC}"
if [ "$INSTALL_TYPE_SELECTED" = "1" ]; then
    apt-get update
    apt-get install apache2 php5 mysql-client mysql-server libapache2-mod-php5 php5-mysql phpmyadmin git php5-curl libreoffice-writer postfix apache2-utils ntp bzip2 locate bash-completion fail2ban vim
    a2enmod ssl
elif [ "$INSTALL_TYPE_SELECTED" = "2" ]; then
    apt update
    apt-get install apache2 php mariadb-client mariadb-server libapache2-mod-php php-mysql phpmyadmin git php-curl libreoffice-writer postfix apache2-utils ntp bzip2 locate bash-completion fail2ban vim
    a2enmod ssl
fi

# #######################################################################


printf "\n${LPURPLE}"
printf "##########\n"
printf "## Generation of ssh key\n"
printf "##########\n"
printf "${NC}"
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    printf "${WHITE}ssh-keygen${NC}\n"
    ssh-keygen
else
    printf "${WHITE}~/.ssh/id_rsa.pub already exists${NC}\n"
fi

echo "Copy/Paste the next ssh key to atm-server accounts gogs/github before next step (only if we are owner of the server)"
printf "\n${LBLUE}"
cat ~/.ssh/id_rsa.pub
printf "${NC}\n"
read -p "Press key to continue" NOTHING

# #######################################################################


printf "\n${LPURPLE}"
printf "###########################\n"
printf "## Add ssh alias to atmsrv1\n"
printf "###########################\n":
printf "${NC}"
read -p "Public ip of atmsrv1 (blank don't add entry in ~/.ssh/config): " IP_SRV1
if [ -n "$IP_SRV1" ]; then
    if [ -f ~/.ssh/config ]; then
        echo "" >> ~/.ssh/config
    else
        touch ~/.ssh/config
    fi

    echo "Host atmsrv1" >> ~/.ssh/config
    echo "    Hostname $IP_SRV1" >> ~/.ssh/config
    echo "    Port 22" >> ~/.ssh/config
    echo "    User root" >> ~/.ssh/config

    printf "${WHITE}Host atmsrv1 added with $IP_SRV1 address in ~/.ssh/config${NC}\n"
fi

# #######################################################################

IP_PUBLIC=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

printf "\n${LPURPLE}"
printf "#####################################################################\n"
printf "## Create "client" folder, symlink and cp defaults http auth files\n"
printf "#####################################################################\n"
printf "${NC}"
if [ ! -d /home/client ]; then
    printf "${WHITE}mkdir /home/client${NC}\n"
    mkdir /home/client
else
    printf "${WHITE}/home/client already exists${NC}\n"
fi

if [ ! -f /home/client/.htaccess ]; then
    printf "${WHITE}cp .htaccess /home/client/${NC}\n"
    cp .htaccess /home/client/
    printf "${WHITE}sed -i -e \"s/IP_PUBLIC/${IP_PUBLIC}/g\" /home/client/.htaccess${NC}\n"
    sed -i -e "s/IP_PUBLIC/${IP_PUBLIC}/g" /home/client/.htaccess
else
    printf "${WHITE}/home/client/.htaccess already exists${NC}\n"
fi

touch /home/client/.htpasswd

if [ -d /var/www/html ]; then
    if [ ! -L /var/www/html/client ]; then
        printf "${WHITE}ln -s /home/client /var/www/html/client${NC}\n"
        ln -s /home/client /var/www/html/client
    else
        printf "${WHITE}symlink /var/www/html/client -> /home/client already exists${NC}\n"
    fi
else
    if [ ! -L /var/www/client ]; then
        printf "${WHITE}ln -s /home/client /var/www/client${NC}\n"
        ln -s /home/client /var/www/client
    else
        printf "${WHITE}symlink /var/www/client -> /home/client already exists${NC}\n"
    fi
fi

# #######################################################################


printf "\n${LPURPLE}"
printf "#####################################\n"
printf "## Deploying scripts to go in crontab\n"
printf "#####################################\n"
printf "${NC}"

if [ ! -f ~/dump-all.sh ]; then
    printf "${WHITE}cp dump-all.sh ~/${NC}\n"
    cp dump-all.sh ~/
else
    printf "${WHITE}~/dump-all.sh already exists${NC}\n"
fi

if [ ! -f ~/sync-monster.sh ]; then
    printf "${WHITE}cp sync-monster.sh ~/${NC}\n"
    cp sync-monster.sh ~/

    echo ""

    read -p "Give the intranet url without https:// (only foo.fr)" intranet_position
    printf "${WHITE}sed -i -e \"s/intranet_position/${intranet_position}/g\" ~/sync-monster.sh${NC}\n"
    sed -i -e "s/intranet_position/${intranet_position}/g" ~/sync-monster.sh
else
    printf "${WHITE}~/sync-monster.sh${NC}\n"
fi
echo ""
read -p "Please, don't forget to add the server ip (${IP_PUBLIC}) in the .htaccess of [passgen] module for sync-monster (only if we are owner of the server)" NOTHING

# #######################################################################


printf "\n${LPURPLE}"
printf "##################\n"
printf "## Install certbot\n"
printf "##################\n"
printf "${NC}"

while :
do
    read -p "y/n" INSTALL_CERTBOT

    if [ "$INSTALL_CERTBOT" = "n" ]; then
        break;
    elif [ "$INSTALL_CERTBOT" = "y" ]; then
        if [ ! -d /home/ssl-cert ]; then
            printf "${WHITE}mkdir /home/ssl-cert${NC}\n"
            mkdir /home/ssl-cert
        else
            printf "${WHITE}/home/ssl-cert already exists${NC}\n"
        fi

        if [ ! -f /home/ssl-cert/certbot-auto ]; then
            printf "${WHITE}cp  certbot-auto /home/ssl-cert/${NC}\n"
            cp  certbot-auto /home/ssl-cert/
        else
            printf "${WHITE}/home/ssl-cert/certbot-auto already exists${NC}\n"
        fi

        break;
    fi
done

# #######################################################################

#if [ -z "$HOME" ]; then            # Variable global, pas besoin de l'init normalement
#    HOME=$(eval echo ~$USER)
#fi

printf "\n${LPURPLE}"
printf "##########\n"
printf "## Crontab\n"
printf "##########\n"
printf "\n${NC}"

touch mycron_tmp
echo "0	0	*	*	*	${HOME}/dump-all.sh" >> mycron_tmp          # echo new cron lines into "mycron" file
echo "30	12	*	*	*	${HOME}/dump-all.sh" >> mycron_tmp
echo "0	6	*	*	*	${HOME}/sync-monster.sh" >> mycron_tmp
if [ "$INSTALL_CERTBOT" = "y" ]; then
    echo "0	6	*	*	*	/home/ssl-cert/certbot-auto renew --quiet --no-self-upgrade" >> mycron_tmp
fi

echo "Add this entries into crontab?"
cat mycron_tmp                                      # show new entries

while :
do
    read -p "y/n" ADD_CRON_ENTRIES

    if [ "$ADD_CRON_ENTRIES" = "n" ]; then
        break
    elif [ "$ADD_CRON_ENTRIES" = "y" ]; then
        crontab -l > mycron                         # write out current crontab in temporary file
        cat mycron_tmp >> mycron

        crontab mycron                              # install new cron file
        rm mycron                                   # remove temporary file
        printf "${WHITE}crontab -l${NC}\n"
        crontab -l
        echo ""

        break;
    fi
done

rm mycron_tmp                                       # remove temporary file

