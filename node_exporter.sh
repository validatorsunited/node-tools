#!/bin/bash
cd $HOME
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.0/node_exporter-1.6.0.linux-amd64.tar.gz
tar -xzvf node_exporter-1.6.0.linux-amd64.tar.gz 
sudo chmod +x node_exporter-1.6.0.linux-amd64/node_exporter
sudo mv node_exporter-1.6.0.linux-amd64/node_exporter /usr/local/bin/
rm node_exporter-1.6.0.linux-amd64.tar.gz

echo "[Unit]
Description=Node Exporter
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/node_exporter
Restart=on-failure
LimitNOFILE=524280

[Install]
WantedBy=multi-user.target" > $HOME/nodeexpd.service

sudo mv $HOME/nodeexpd.service /etc/systemd/system

sudo systemctl daemon-reload
sudo systemctl enable nodeexpd.service
sudo systemctl start nodeexpd.service
