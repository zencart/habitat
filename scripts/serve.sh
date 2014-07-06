#!/usr/bin/env bash

# $1 = skeleton file name - currently only apache.default
# $2 = server name e.g. zen.local
# $3 = document root
# $4 = Git repository - can be null 
# $5 = git branch - can be null 

INPUT_FILE=/home/vagrant/scripts/skeletons/$1
OUTPUT_FILE=/home/vagrant/$2.conf
echo "skeleton = $INPUT_FILE"
echo "server conf = $OUTPUT_FILE"
echo "Document Root = $3"
echo "Git Repository = $4"
echo "Git Branch = $5"

sed "s/SERVER_NAME/$2/g;s/DOCUMENT_ROOT/$3/g" $INPUT_FILE > $OUTPUT_FILE
sudo mv $OUTPUT_FILE /etc/apache2/sites-available/

if [ -d "$DIRECTORY" ]; then
  sudo mkdir /home/vagrant/web/$3
fi

sudo a2ensite $2.conf > /dev/null 2>&1
sudo service apache2 restart > /dev/null 2>&1

if [ ! -z "$4" ]; then 
 
  echo "Trying to Clone v160 > web/zen"

  if [ "$(ls -A /home/vagrant/web/$3  > /dev/null 2>&1)" ]; then
    echo "Take action /home/vagrant/web/$3 is not Empty"
  else
    echo "/home/vagrant/web/$3 is Empty"
    sudo git clone $4 /home/vagrant/web/$3
    cd /home/vagrant/web/$3
    sudo git checkout $5
  fi
fi
