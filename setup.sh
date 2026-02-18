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

echo "Starting and enabling Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Adding ubuntu user to docker group..."
sudo usermod -aG docker ubuntu

echo "Stopping old containers (if any)..."
sudo docker compose down || true

echo "Building and starting containers..."
sudo docker compose up -d --build

echo "Setup completed successfully."

#new if added more