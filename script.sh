#!/bin/bash
for I in {1..10}; do
    echo "Welcome $I"
    sleep 1
done
apt update -y
apt install -y nginx jq unzip net-tools
curl https://get.docker.com | sudo bash
sudo docker version
sudo docker stop app1 || true
sudo docker run --rm -d --name app1 -p 80:80 sreeharshav/testcontainer:v1
sudo docker ps
