#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sed -i 's/listen       80;/listen       31555;/g' /etc/nginx/nginx.conf
sudo systemctl enable nginx
sudo systemctl start nginx