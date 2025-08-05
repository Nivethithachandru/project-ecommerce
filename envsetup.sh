#!/bin/bash

set -e

PROJECT_DIR="/var/lib/jenkins/workspace"
VENV_PATH="/var/lib/jenkins/workspace/venv"


sudo chmod u+x /var/lib/jenkins
sudo chmod u+x "$PROJECT_DIR"


if [ ! -f "VENV_PATH/bin/activate" ]; then
    echo "Creating virtual environment at $VENV_PATH..."
    python3 -m venv "$VENV_PATH" || { echo "Failed to create virtual environment"; exit 1; }
else
    echo "Virtual environment already exists at $VENV_PATH"
fi


echo "Activating virtual environment..."
source "VENV_PATH/bin/activate"


cd "$PROJECT_DIR/project_Ecommerce" || { echo "django_webpage directory not found"; exit 1; }


echo "Installing Python dependencies..."
pip install --upgrade pip setuptools
pip install -r requirements.txt

if [ ! -d "logs" ]; then
    echo "Creating log directory and files..."
    mkdir logs
    touch logs/error.log logs/access.log
else
    echo "Log directory already exists."
fi

chmod -R 777 logs 

echo "Environment setup complete"
