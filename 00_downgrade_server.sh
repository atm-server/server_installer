apt-get install software-properties-common
add-apt-repository ppa:ondrej/php
apt-get update
apt-get install php7.0 php5.6 php5.6-mysql php-gettext php5.6-mbstring php-xdebug libapache2-mod-php5.6 libapache2-mod-php7.0

echo '[mysqld]' > /etc/mysql/conf.d/disable_strict_mode.cnf
echo 'sql_mode=IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' >> /etc/mysql/conf.d/disable_strict_mode.cnf


a2dismod php7.0 ; sudo a2enmod php5.6 ; sudo service apache2 restart

