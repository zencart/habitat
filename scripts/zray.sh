#!/usr/bin/env bash

if [ "$1" == "--help" ]; then
echo "zray.sh"
echo "This script will install the Zend Z-Ray tools into this vagrant box."
echo "  usage:  zray.sh   [--help]"
echo ""
exit 0
fi

if [ ! -d /etc/nginx ]; then
  echo "ERROR: nginx not found. Cannot install using this script."
  echo "-----"
  exit 0
fi

echo "Installing Zend Z-Ray ..."

printf "server {
  listen 10081 default_server;
  server_name _;
  server_name_in_redirect off;
  root /opt/zray/gui/public;
  index index.php index.html index.htm;
  location ~ ^/ZendServer/(.+)$ {
    try_files /$1 /index.php?$args;
  }
  location / {
    try_files $uri $uri/ /index.php$is_args$args;
  }
  location ~ \.php$ {
    fastcgi_pass unix:/var/run/php5-fpm.sock;
    fastcgi_index index.php;
    include fastcgi_params;
  }
}" \
| tee -a /etc/nginx/conf.d/zray.conf

cd ~
if [ ! -f zray-php5.6-Ubuntu-14.04-x86_64.tar.gz ]; then
  wget http://downloads.zend.com/zray/1208/zray-php5.6-Ubuntu-14.04-x86_64.tar.gz
fi

sudo su <<'EOF'
tar xvfz zray-php5.6-Ubuntu-14.04-x86_64.tar.gz -C /opt
#sudo chown -R vagrant:vagrant /opt/zray
ln -sf /opt/zray/zray.ini /etc/php5/cli/conf.d/zray.ini 
ln -sf /opt/zray/zray.ini /etc/php5/fpm/conf.d/zray.ini
php -v | grep Z-Ray
service nginx restart
EOF

#rm -rf zray*

echo "Done."
echo "You can now access Zend Z-Ray by visiting port 10081 on your VM. ie: http://172.22.22.22:10081"
echo ""
