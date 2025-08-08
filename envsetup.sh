#!/bin/bash

set -e
set -x

PROJECT_DIR="/var/lib/jenkins/workspace"
VENV_PATH="/var/lib/jenkins/workspace/venv"

sudo chmod u+x /var/lib/jenkins/workspace
sudo chmod u+x "$PROJECT_DIR"


if [ ! -f "$VENV_PATH/bin/activate" ]; then
    echo "Creating virtual environment at $VENV_PATH..."
    python3 -m venv "$VENV_PATH" || { echo "Failed to create virtual environment"; exit 1; }
else
    echo "Virtual environment already exists at $VENV_PATH"
fi


echo "Activating virtual environment..."
source "$VENV_PATH/bin/activate"

sudo chown -R jenkins:jenkins /var/lib/jenkins/workspace/venv

cd "$PROJECT_DIR/project_Ecommerce" || { echo "django_webpage directory not found"; exit 1; }
sudo chmod u+x "$PROJECT_DIR/project_Ecommerce"

echo "Installing Python dependencies..."
pip install --upgrade pip setuptools
pip install --upgrade pip
pip install django-jazzmin
pip freeze > requirements.txt
pip install -r requirements.txt
python -m pip install Pillow
pip install razorpay

if [ ! -d "logs" ]; then
    echo "Creating log directory and files..."
    mkdir logs
    touch logs/error.log logs/access.log
else
    echo "Log directory already exists."
fi

chmod -R 777 logs

echo "Environment setup complete"
