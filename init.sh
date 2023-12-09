#!/bin/bash
cat <<EOF | sudo tee /etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - RHEL 7
baseurl = https://repos.influxdata.com/rhel/7/x86_64/stable
enabled = 1
gpgcheck = 0
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
sudo yum install influxdb -y
sudo systemctl start influxdb
sudo systemctl enable influxdb
curl https://s3.amazonaws.com/noaa.water-database/NOAA_data.txt -o NOAA_data.txt
influx -import -path=NOAA_data.txt -precision=s -database=NOAA_water_database