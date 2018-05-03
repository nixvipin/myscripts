
echo -e "\nPlease install using puppet/ansible\n"

exit 1


APACHE_VER=2.4.33
APR_VER=1.6.3
APR_UTIL_VER=1.5.4

yum install unzip -y

echo -e "\n\e[32m ...Installing Pre-requisite for Apache...\e[0m\e"

mkdir -p /data/packages
cd /data/packages
yum install pcre-devel openldap-devel gcc gcc-c++ -y
wget "http://downloads.sourceforge.net/project/pcre/pcre/8.38/pcre-8.38.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fpcre%2Ffiles%2F&ts=1457610526&use_mirror=liquidtelecom" -O pcre-8.38.zip
unzip pcre-8.38.zip
cd pcre-8.38
./configure --prefix=/usr/local/pcre
make
make install

echo -e "\n\e[32m ...Installing Apache... \e[0m\n"

yum install openssl-devel -y

cd /data/packages
wget https://www.apache.org/dist/httpd/httpd-$APACHE_VER\.tar.gz
wget http://www-eu.apache.org/dist/apr/apr-$APR_VER\.tar.gz
wget https://archive.apache.org/dist/apr/apr-util-$APR_UTIL_VER\.tar.gz

tar -zxf httpd-$APACHE_VER\.tar.gz; tar -zxf apr-$APR_VER\.tar.gz; tar -zxf apr-util-$APR_UTIL_VER\.tar.gz

mkdir -p  /data/packages/httpd-$APACHE_VER/srclib
mv apr-$APR_VER /data/packages/httpd-$APACHE_VER/srclib/apr
mv apr-util-$APR_UTIL_VER /data/packages/httpd-$APACHE_VER/srclib/apr-util

cd httpd-$APACHE_VER

./configure --prefix=/data/apache2 --enable-proxy --enable-proxy-http --enable-proxy-connect --enable-proxy-balancer  --enable-ssl --enable-ldap --enable-authnz-ldap --enable-so --with-included-apr --with-pcre=/usr/local/pcre --enable-rewrite  --with-mpm=worker --enable-dav_svn --with-pcre=/usr/local/pcre --enable-mods-shared=all  --enable-auth-diges --enable-setenvif --enable-mime --enable-headers --with-ldap ap_cv_void_ptr_lt_long=4
make
make install


echo -e "\n\e[32m ...Follow below steps manually to configure the site...\e[0m\n"

echo -e "1.\e[32m Open /data/apache2/conf/httpd.conf and Uncomment Below modules\e[0m\n

LoadModule proxy_ajp_module modules/mod_proxy_ajp.so
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so
LoadModule proxy_connect_module modules/mod_proxy_connect.so
LoadModule proxy_balancer_module modules/mod_proxy_balancer.so
LoadModule slotmem_shm_module modules/mod_slotmem_shm.so
LoadModule slotmem_plain_module modules/mod_slotmem_plain.so
LoadModule proxy_express_module modules/mod_proxy_express.s
LoadModule proxy_hcheck_module modules/mod_proxy_hcheck.so
LoadModule lbmethod_byrequests_module modules/mod_lbmethod_byrequests.so
LoadModule watchdog_module modules/mod_watchdog.so
LoadModule proxy_hcheck_module modules/mod_proxy_hcheck.so

"

echo -e "2.\e[32m Open /data/apache2/conf/httpd.conf and add 'Include conf/extra/etlhive.conf'\e[0m\n"

echo -e "3.\e[32m Open /data/apache2/conf/extra/etlhive.conf and  add below -->\e[0m\n


<VirtualHost *:80>
    ServerName www.etlhive.com
        ProxyPreserveHost On

                   ProxyPass /employee "http://127.0.0.1:8001/employee"
                   ProxyPassReverse /employee "http://127.0.0.1:8001/employee"


         ErrorLog logs/apache_error.log
         CustomLog logs/apache_access.log combined
</VirtualHost>

"

echo -e "4.\e[32m Execute "/data/apache2/bin/apachectl -k restart" to restart apache\e[0m"

echo -e "5.\e[32m Verify if apache is running 'ps -ef' command.\e[0m\n"

echo -e "Done!\n"

cd /data/packages/
rm apr-1.6.3.tar.gz apr-util-1.5.4.tar.gz httpd-2.4.33.tar.gz pcre-8.38.zip

