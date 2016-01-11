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
git clone git@github.com:ATM-Consulting/dolibarr_module_contactdefault.git contactdefault
git clone git@github.com:ATM-Consulting/dolibarr_module_history.git history
git clone git@github.com:ATM-Consulting/dolibarr_module_searcheverywhere.git searcheverywhere
git clone git@github.com:ATM-Consulting/dolibarr_module_related.git related
git clone git@github.com:ATM-Consulting/dolibarr_module_sendproductdoc.git sendproductdoc
git clone git@github.com:ATM-Consulting/dolibarr_module_propalehistory.git propalehistory
git clone git@github.com:ATM-Consulting/dolibarr_module_split.git split

