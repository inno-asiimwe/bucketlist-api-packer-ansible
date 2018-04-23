#!/bin/bash -eux

# Install supervisor
echo 'installing supervisor'
sudo apt-get install -y supervisor

# copy premade configs
echo 'copy supervisor config'
ls -a /tmp
sudo cp /tmp/bucketlist-api-gcp.conf /etc/supervisor/conf.d

echo 'restarting supervisor --------'
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl start bucketlist-api-gcp

echo '-----end-----'