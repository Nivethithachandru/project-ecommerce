#!/bin/bash

set -e

cd /var/lib/jenkins/workspace

source "venv/bin/activate"

cd /var/lib/jenkins/workspace/project_Ecommerce/core

python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py collectstatic --noinput

echo " Migrations and static file collection completed."

cd ..

if [ -f "ecommerce.service" ]; then
    sudo cp -rf "ecommerce.service" /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo systemctl enable "ecommerce.service"
    sudo systemctl restart "ecommerce.service"
    echo "Ecommerce service deployed and restarted."
else
    echo "ecommerce.service not found in $PROJECT_DIR"
    exit 1
fi
