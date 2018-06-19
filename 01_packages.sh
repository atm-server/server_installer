apt-get update
apt-get install apache2 php mariadb-client mariadb-server libapache2-mod-php php-mysql phpmyadmin git php-curl libreoffice-writer postfix apache2-utils ntp bzip2 locate bash-completion fail2ban vim
a2enmod ssl

echo "mysql -u root -p"
echo "Enter Password : (vous tapez entrer)"
 
echo "MariaDB [(none)]> UPDATE mysql.user SET plugin = NULL WHERE user = 'root' AND plugin = 'unix_socket';"
echo "MariaDB [(none)]> FLUSH PRIVILEGES;"
echo "MariaDB [(none)]> SET PASSWORD FOR root@'localhost'=PASSWORD('mon_nouveau_mot-de_passe');"
