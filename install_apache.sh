#!/bin/bash
sudo -i
# update/upgrade system
sudo apt-get update -y
echo "apt updated"
sudo apt-get upgrade -y
echo "apt upgraded"
# install nginx, MySQL, php
sudo apt-get install nginx -y; sudo apt-get install mysql-server -y; sudo apt-get install php-fpm php-mysql -y

# start everything
sudo systemctl start nginx; sudo systemctl start MySQL; sudo systemctl start php7.4-fpm

# enable everything (will start after reboot)
sudo systemctl enable nginx; sudo systemctl enable MySQL; sudo systemctl enable php7.4-fpm

# Secure MySQL installation (not done before, c+p chat)
sudo mysql_secure_installation <<EOF

y
pa55word
pa55word
y
y
y
y
EOF

# nginx config (php not done before, c+p chat, placeholders for server/domain)
echo "server {
    listen 80;
    SSH_HOST;

    root /var/www/html;
    index index.php index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
    }
}" > /etc/nginx/sites-available/default 

# edit index page
echo "<h1>Great Success!<h1>" > /var/www/html/index.html

# nginx restart
sudo systemctl restart nginx

# Create a test PHP file (not done before, c+p from chat)
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

echo "LEMP stack installation completed. You legend"
