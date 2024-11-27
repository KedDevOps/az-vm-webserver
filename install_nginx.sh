#!/bin/bash
# Update packages
sudo apt update && sudo apt upgrade -y
# Install Nginx
sudo apt install nginx -y
# Ensure Nginx is running
sudo systemctl start nginx
sudo systemctl enable nginx
