mkdir /home/_default
cd /home/_default
git clone git@github.com:ATM-Consulting/dolibarr.git
cd /home/_default/dolibarr/ & git checkout 3.5
mkdir /home/_default/dolibarr/htdocs/custom
cd /home/_default/dolibarr/htdocs/custom

ln -s /home/_default /var/www/_default
