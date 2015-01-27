mkdir /home/_default
mkdir /home/client

touch /home/client/.htpasswd

cd /home/_default
git clone git@atmsrv1:rh.git dynamicrh

cd /home/_default/dynamicrh/ 
git checkout 3.5
git pull
git submodule init
git submodule update
git submodule foreach git pull



