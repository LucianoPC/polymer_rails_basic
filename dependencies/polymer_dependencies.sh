#!/bin/bash

echo "Install Polymer Dependency: Git"
sudo apt-get install git -y

echo "Install Polymer Dependency: LibSSL-Dev"
sudo apt-get install libssl-dev -y

echo "Install Polymer Dependency: NodeJS"
sudo apt-get install nodejs -y
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo mkdir /usr/lib/node_modules
sudo chown -R vagrant /usr/{lib/node_modules,bin,share}

echo "Install Polymer Dependency: Curl"
sudo apt-get install curl -y

echo "Install Polymer Dependency: NPM"
curl -L https://www.npmjs.com/install.sh | sh
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo "export PATH=~/.npm-global/bin:\$PATH" >> ~/.profile
source ~/.profile

echo "Install Polymer Dependency: Bower"
npm install -g bower

echo "Install Polymer Dependency: Polymer"
npm install -g polymer-cli

echo "Run Bower Install"
cd /vagrant/polymer_basic
bower install
