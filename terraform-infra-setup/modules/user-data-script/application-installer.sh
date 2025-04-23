#! /bin/bash
cd /home/ubuntu

# Install necessary dependencies
yes | sudo apt update
yes | sudo apt install python3.12 python3.12-venv python3-pip python3-dev default-libmysqlclient-dev build-essential git -y

# Set default python3 and pip to python3.12
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1

# Clone your repo
git clone https://github.com/KushalNishad/Dockerized-Flask-app.git
cd Dockerized-Flask-app

# Create and activate virtual environment
python3.12 -m venv venv
source venv/bin/activate

# Upgrade pip and install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Start the app and log output
nohup python3 app.py > /home/ubuntu/flask.log 2>&1 &
