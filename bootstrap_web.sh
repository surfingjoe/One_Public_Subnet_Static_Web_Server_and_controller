#!/bin/bash
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y apache2
hostnamectl set-hostname Web
apt-get install -y awscli
sudo aws s3 cp s3://S3-bucket-name /var/www/html/. --recursive
