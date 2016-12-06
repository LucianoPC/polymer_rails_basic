#!/bin/bash

echo "Update Debian Jessie to Sid"
sudo apt-get update
sudo cp /vagrant/vagrant/sources.list /etc/apt/sources.list
sudo apt-get update
sudo apt-get dist-upgrade -y

echo "Install basic dependencies"
sudo apt-get install vim -y
sudo apt-get install mkalias -y
sudo apt-get install build-essential -y

echo "Install Rails"
./dependencies/rails_dependencies.sh

echo "Create alias '$ rs' to run Rails Server"
mkalias new rs "cd /vagrant/rails_basic" "rails s -b 0.0.0.0 #@"
