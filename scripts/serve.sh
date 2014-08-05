#!/usr/bin/env bash

# $1 = skeleton file name - currently only apache.default or nginx.default
# $2 = server name e.g. zen.local
# $3 = document root
# $4 = Git repository - can be null
# $5 = git branch - can be null

INPUT_FILE=/home/vagrant/scripts/skeletons/$1
OUTPUT_FILE=/home/vagrant/$2
echo "skeleton = $INPUT_FILE"
echo "server conf = $OUTPUT_FILE"
echo "Document Root = $3"
echo "Git Repository = $4"
echo "Git Branch = $5"

# make document root folder if not present
if [ -d "$DIRECTORY" ]; then
  sudo mkdir /home/vagrant/web/$3
fi

# create and enable vhost
sed "s/SERVER_NAME/$2/g;s/DOCUMENT_ROOT/$3/g" $INPUT_FILE > $OUTPUT_FILE

if [[ "$1" =~ nginx.* ]]; then
  sudo mv $OUTPUT_FILE /etc/nginx/sites-available/$2
  ln -s "/etc/nginx/sites-available/$2" "/etc/nginx/sites-enabled/$2"
  service nginx restart
  service php5-fpm restart > /dev/null 2>&1
else
  sudo mv $OUTPUT_FILE /etc/apache2/sites-available/$2.conf
  sudo a2ensite $2.conf
  sudo service apache2 restart > /dev/null 2>&1
fi

# do any repo checkouts necessary
if [ ! -z "$4" ]; then

  if [ "$(ls -A /home/vagrant/web/$3  > /dev/null 2>&1)" ]; then
    echo "Take action /home/vagrant/web/$3 is not Empty"
  else
    echo "/home/vagrant/web/$3 is Empty"
    sudo git clone $4 /home/vagrant/web/$3
    cd /home/vagrant/web/$3
    sudo git checkout $5
  fi
fi
