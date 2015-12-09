mkdir /home/_default
mkdir /home/client

touch /home/client/.htpasswd

cd /home/_default
git clone git@github.com:ATM-Consulting/dolibarr.git --branch 3.8 --single-branch

cd /home/_default/dolibarr/ 
git pull

mkdir /home/_default/dolibarr/documents
chmod 777 /home/_default/dolibarr/documents

mkdir /home/_default/dolibarr/htdocs/custom
cd /home/_default/dolibarr/htdocs/custom

git clone git@github.com:ATM-Consulting/dolibarr_module_subtotal.git subtotal
git clone git@github.com:ATM-Consulting/dolibarr_module_docpreview.git docpreview
git clone git@github.com:ATM-Consulting/dolibarr_module_abricot.git abricot
#git clone git@atmsrv1:doli-report report
git clone git@github.com:ATM-Consulting/dolibarr_module_breadcrumb.git breadcrumb
git clone git@github.com:ATM-Consulting/dolibarr_module_query.git query
git clone git@github.com:ATM-Consulting/dolibarr_module_fullcalendar.git fullcalendar
git clone git@github.com:ATM-Consulting/dolibarr_module_upbuttons.git upbuttons


