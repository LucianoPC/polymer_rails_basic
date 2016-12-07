#!/bin/bash

echo "Install Polymer Dependency: Git"
sudo apt-get install git -y

echo "Install Rails Dependency: Build-Essential"
sudo apt-get install build-essential -y

echo "Install Polymer Dependency: Curl"
sudo apt-get install curl -y

echo "Install Polymer Dependency: LibSSL-Dev"
sudo apt-get install libssl-dev -y

echo "Install Polymer Dependency: NodeJS"
curl https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | bash
source ~/.profile
nvm install 6.9.0
nvm use 6.9.0

echo "Install Polymer Dependency: NPM"
curl -L https://www.npmjs.com/install.sh | sh

echo "Install Polymer Dependency: Bower"
npm install -g bower

echo "Install Polymer Dependency: Polymer"
npm install -g polymer-cli --verbose
