#!/bin/bash

set -e
set -x

sudo cp -r demo /etc/nginx/sites-available/demo

if [ ! -L /etc/nginx/sites-enabled/demo ]; then
    sudo ln -s /etc/nginx/sites-available/demo /etc/nginx/sites-enabled/demo
fi

sudo chmod 710 /var/lib/jenkins/workspace/project_Ecommerce

sudo nginx -t

sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl restart nginx

echo "Nginx has been started"

sudo systemctl status nginx
