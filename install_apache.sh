
APACHE_VER=2.4.33
APR_VER=1.6.3
APR_UTIL_VER=1.5.4

echo -e "\e[32m ...Installing Pre-requisite for Apache...\e[0m "

mkdir -p /data/packages
cd /data/packages
yum install pcre-devel openldap-devel gcc gcc-c++ -y
wget "http://downloads.sourceforge.net/project/pcre/pcre/8.38/pcre-8.38.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fpcre%2Ffiles%2F&ts=1457610526&use_mirror=liquidtelecom" -O pcre-8.38.zip
unzip pcre-8.38.zip
cd pcre-8.38
./configure --prefix=/usr/local/pcre
make
make install

echo -e "\e[32m ...Installing Apache... "

yum install openssl-devel -y

wget https://www.apache.org/dist/httpd/httpd-$APACHE_VER.tar.gz
wget http://www-eu.apache.org/dist//apr/apr-$APR_VER.tar.gz
wget https://archive.apache.org/dist/apr/apr-util-$APR_UTIL_VER.tar.gz

tar -zxf httpd-$APACHE_VER.tar.gz; tar -zxf apr-$APR_VER.tar.gz; tar -zxf apr-util-$APR_UTIL_VER.tar.gz

mv apr-$APR_VER /data/packages/httpd-$APACHE_VER/srclib/apr
mv apr-util-$APR_UTIL_VER /data/packages/httpd-$APACHE_VER/srclib/apr-util

cd httpd-$APACHE_VER

./configure --prefix=/data/apache2 --enable-proxy --enable-proxy-http --enable-proxy-connect --enable-proxy-balancer  --enable-ssl --enable-ldap --enable-authnz-ldap --enable-so --with-included-apr --with-pcre=/usr/local/pcre --enable-rewrite  --with-mpm=worker --enable-dav_svn --with-pcre=/usr/local/pcre --enable-mods-shared=all  --enable-auth-diges --enable-setenvif --enable-mime --enable-headers --with-ldap ap_cv_void_ptr_lt_long=4
make
make install

/data/apache2/bin/httpd -t

echo -e "\eOpen /data/apache2/conf/httpd.conf and Uncomment  LoadModule proxy_module modules/mod_proxy.so and LoadModule proxy_http_module modules/mod_proxy_http.so lines"
echo -e "\eOpen /data/apache2/conf/httpd.conf and change "ServerName www.etlhive.com:80"\e"

echo -e "\eOpen /data/apache2/conf/httpd.conf and add "Include conf/extra/etlhive.conf""

echo -e "\eOpen /data/apache2/conf/extra/etlhive.conf and  add below --> 


<VirtualHost 192.168.56.101:80>
   ServerName www.etlhive.com
   Options ExecCGI
   ProxyPreserveHost On
 
        ProxyPass / http://192.168.56.101:8001/employee
        ProxyPassReverse / http://192.168.56.101:8001/employee
		
		ProxyPass /jenkins http://192.168.56.101:8007/jenkins/
        ProxyPassReverse /jenkins http://192.168.56.101:8007/jenkins/
 
        ErrorLog logs/apache_error.log
        CustomLog logs/apache_access.log combined
 
</VirtualHost>

"

/data/apache2/bin/httpd -t

if [ $? = 0 ]
then
echo -e "\eApache Installation successfully completed..Starting now.."
/data/apache2/bin/apachectl
else
echo -e "\eApache validation syntax failed.. Please verify above installation logs.." 
exit 1
fi


