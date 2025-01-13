#!/bin/bash                                                                                sngrok.sh                                                                                                  
echo "--------- 🟢 Start Docker compose down  -----------"
docker compose down
echo "--------- 🔴 Finish Docker compose down -----------"
echo "--------- 🟢 Start Ngrok setup -----------"
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
sudo tar xvzf ./ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin
sudo apt install -y jq
echo "🔴🔴🔴 Please login into ngrok.com and paste your token here:"
read -p "Token : " token
ngrok config add-authtoken $token
ngrok http 80 > /dev/null &
echo "🔴🔴🔴 Please wait Ngrok to start...."
sleep 5
export EXTERNAL_IP="$(curl http://localhost:4040/api/tunnels | jq ".tunnels[0].public_url")"
echo Got Ngrok URL = $EXTERNAL_IP
echo "--------- 🔴 Finish Ngrok setup -----------"
echo "--------- 🟢 Start Docker compose up  -----------"
docker compose up -d
echo "--------- 🔴 Finish! Wait a few minutes and test in browser at url $EXTERNAL_IP for n8n UI -----------"