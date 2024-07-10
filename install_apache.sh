#!/bin/bash
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
echo "You have successfully installed Apache webserver"
