#!/bin/bash

echo "Update Debian Jessie to Sid"
sudo apt-get update
sudo cp /vagrant/vagrant/sources.list /etc/apt/sources.list
sudo apt-get update
sudo apt-get dist-upgrade -y
