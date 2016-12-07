#!/bin/bash

echo "Update Debian Jessie to Sid"
sudo apt-get update
sudo cp /vagrant/vagrant/sources.list /etc/apt/sources.list
sudo apt-get update
sudo apt-get dist-upgrade -y

echo "Install basic dependencies"
sudo apt-get install vim -y
sudo apt-get install mkalias -y
mkalias add_signal
source ~/.bashrc

echo "Install Rails"
/vagrant/dependencies/rails_dependencies.sh

echo "Install Polymer"
/vagrant/dependencies/polymer_dependencies.sh

echo "Run Bundle install on Rails Project"
cd /vagrant/rails_basic
bundle install

echo "Run database migrations"
rake db:migrate

echo "Run Bower Install"
cd /vagrant/polymer_basic
bower install

echo "Create alias '$ rs' to run Rails Server"
mkalias new rs "cd /vagrant/rails_basic" "rails s -b 0.0.0.0 #@"

echo "Create alias '$ ps' to run Polymer Server"
mkalias new rs "cd /vagrant/polymer_basic" "polymer serve -H 0.0.0.0 #@"
