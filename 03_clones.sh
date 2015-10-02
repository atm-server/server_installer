mkdir /home/_default
mkdir /home/client

touch /home/client/.htpasswd

cd /home/_default
git clone git@github.com:ATM-Consulting/dolibarr.git

cd /home/_default/dolibarr/ 
git checkout 3.6
git pull

mkdir /home/_default/dolibarr/documents
chmod 777 /home/_default/dolibarr/documents

mkdir /home/_default/dolibarr/htdocs/custom
cd /home/_default/dolibarr/htdocs/custom

git clone git@github.com:ATM-Consulting/dolibarr_module_subtotal.git subtotal
git clone git@github.com:ATM-Consulting/dolibarr_module_docpreview.git docpreview
git clone git@github.com:ATM-Consulting/dolibarr_module_abricot.git abricot
git clone git@atmsrv1:doli-report report
git clone git@github.com:ATM-Consulting/dolibarr_module_breadcrumb.git breadcrumb


