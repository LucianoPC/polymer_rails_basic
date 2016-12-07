#!/bin/bash

echo "Install Rails Dependency: Ruby"
sudo apt-get install ruby -y
sudo apt-get install ruby-dev -y

echo "Install Rails Dependency: Build-Essential"
sudo apt-get install build-essential -y

echo "Install Rails Dependency: NodeJS"
sudo apt-get install nodejs -y

echo "Install Rails Dependency: Nokogiri"
sudo apt-get install ruby-nokogiri -y

echo "Install Rails Dependency: Nio4r"
sudo apt-get install ruby-nio4r -y

echo "Install Rails Dependency: Websocket Extensions"
sudo apt-get install ruby-websocket-extensions -y

echo "Install Rails Dependency: Websocket Extensions"
sudo apt-get install ruby-websocket-driver -y

echo "Install Rails Dependency: Bcrypt"
sudo apt-get install ruby-bcrypt -y

echo "Install Rails Dependency: PostgresSQL Server"
sudo apt-get install postgresql-server-dev-all -y

echo "Install Rails Dependency: SQLite3"
sudo apt-get install sqlite3 libsqlite3-dev -y

echo "Install gem Rails 5"
sudo gem install rails
