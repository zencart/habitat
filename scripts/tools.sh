#!/usr/bin/env bash

if [ "$1" == "--help" ]; then
echo "tools.sh"
echo "This script copies various unit-testing tools to the /home/vagrant/habitat/tools folder."
echo "It will not overwrite if the unittest file already exists, but if you wish to overwrite anyway, simply pass 'overwrite' as a parameter."
echo "  usage:  tools.sh  [overwrite] [--help]"
echo "          tools.sh  (with no parameters will skip overwrite)"
echo ""
exit 0
fi

if [ ! -f /home/vagrant/habitat/tools/unittest -o "$1" == "overwrite" ]; then
  echo "Installing localized unit-testing tools ..."
  cp -r  /home/vagrant/tools /home/vagrant/habitat
  echo "Done."
fi
