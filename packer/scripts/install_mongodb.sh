#!/bin/bash

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/5.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list
curl -fsSL https://www.mongodb.org/static/pgp/server-5.0.asc| gpg --dearmor -o /etc/apt/trusted.gpg.d/mongodb-5.gpg
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7AE645C0CF8E292A 
apt update
apt install  mongodb-org -y
systemctl start mongod 
systemctl enable mongod 