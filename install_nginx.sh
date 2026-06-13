#!/bin/bash

sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

cp hello.html /var/www/html

sudo systemctl start nginx

echo "Devboard Running on Port 80"
