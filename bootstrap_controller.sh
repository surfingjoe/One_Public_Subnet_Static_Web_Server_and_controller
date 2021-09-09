#!/bin/bash
sudo apt-get update
sudo apt-get -y upgrade
hostnamectl set-hostname Controller
sudo apt-get install -y ansible