#!/bin/bash

set -e

sudo chmod u+x nginx.sh 

sudo cp ecom /etc/nginx/sites-available/ecom

if [ ! -L /etc/nginx/sites-enabled/ecom ]; then
    sudo ln -s /etc/nginx/sites-available/ecom /etc/nginx/sites-enabled/ecom
fi

sudo chmod 710 /var/lib/jenkins/workspace/project_Ecommerce

sudo nginx -t

sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl restart nginx

echo "Nginx has been started"

sudo systemctl status nginx
