#!/bin/bash
set -e

echo "Updating system..."
sudo apt update -y

echo "Installing Git..."
sudo apt install git -y

echo "Installing Docker..."
if ! command -v docker &> /dev/null
then
  curl -fsSL https://get.docker.com | sudo bash
fi

echo "Enabling Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Adding ubuntu user to docker group..."
sudo usermod -aG docker ubuntu

echo "Installing Nginx..."
if ! command -v nginx &> /dev/null
then
  sudo apt install nginx -y
  sudo systemctl enable nginx
  sudo systemctl start nginx
fi

echo "Checking docker compose..."
docker compose version

echo "Building and starting containers..."
sudo docker compose up -d --build

echo "Setup completed successfully."
