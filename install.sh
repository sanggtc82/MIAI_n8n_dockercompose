#!/bin/bash
echo "--------- 🟢 Start install docker -----------"
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install -y docker-ce
echo "--------- 🟢 Start install nvidia support 4 docker -----------"
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
| sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
| sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
| sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
echo "--------- 🟢 Start creating folder -----------"
cd ~
mkdir vol_localai
mkdir vol_n8n
sudo chown -R 1000:1000 vol_localai
sudo chmod -R 755 vol_localai
sudo chown -R 1000:1000 vol_n8n
sudo chmod -R 755 vol_n8n
echo "--------- 🟢 Start compose up  -----------"
export EXTERNAL_IP=http://"$(hostname -I | cut -f1 -d' ')"
docker compose up -d
echo "--------- 🟢 Finish! Wait and test in browser at url http://VPS_ID:5678 for n8n UI -----------"