#!/bin/bash

echo "Updating system..."
sudo apt update -y

echo "Installing Git..."
sudo apt install git -y

echo "Installing Docker..."
if ! command -v docker &> /dev/null
then
  curl -fsSL https://get.docker.com | sudo bash
  sudo usermod -aG docker ubuntu
fi

echo "Installing Docker Compose..."
if ! command -v docker-compose &> /dev/null
then
  sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

echo "Installing Nginx..."
if ! command -v nginx &> /dev/null
then
  sudo apt install nginx -y
  sudo systemctl enable nginx
  sudo systemctl start nginx
fi

echo "Cloning repository using token..."

if [ ! -d "newnow" ]; then
  git clone https://XI-5515-Akshan:${GITHUB_TOKEN}@github.com/XI-5515-Akshan/newnow.git
fi

echo "Setup completed successfully."
