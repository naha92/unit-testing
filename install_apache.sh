#!/bin/bash
sudo -i
# update/upgrade system
apt update -y
echo "apt updated"
apt upgrade -y
echo "apt upgraded"
# install nginx, MySQL, php
apt install nginx -y; apt install mysql-server -y; apt install php-fpm php-mysql -y

# start everything
systemctl start nginx; systemctl start MySQL; systemctl start php7.4-fpm

# enable everything (will start after reboot)
systemctl enable nginx; systemctl enable MySQL; systemctl enable php7.4-fpm

# Secure MySQL installation (not done before, c+p chat)
mysql_secure_installation <<EOF

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
systemctl restart nginx

# Create a test PHP file (not done before, c+p from chat)
echo "<?php phpinfo(); ?>" | tee /var/www/html/info.php

echo "LEMP stack installation completed. You legend"
