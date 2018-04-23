#!/bin/bash
 
 # install prerequisites
 sudo apt-get update 
 sudo apt-get install -y python3 python3-pip nginx gunicorn git
 
 # clone project repo
 sudo mkdir /var/www && cd /var/www
 echo 'cloning the repo'
 git clone https://github.com/inno-asiimwe/bucketlist-api-gcp.git


 # create and activate virtualenv
 sudo pip3 install virtualenv
 sudo virtualenv -p python3 env
 source env/bin/activate
 # move to prohect directory
 cd bucketlist-api-gcp

 #install project requirements
 echo '<------installing requirements'
 sudo pip3 install -r requirements.txt

 # setup static folder
 sudo mkdir static

 # start nginx
 echo 'starting nginx'
 sudo /etc/init.d/nginx start

echo 'configuring nginx'
 sudo cat <<EOF > /etc/nginx/sites-available/bucketlist-api-gcp
server {
	location / {
		proxy_pass http://localhost:8000;
		proxy_set_header Host $host;
		proxy_set_header X-Real-IP $remote_addr;
	}
	location /static {
		alias /var/www/bucketlist-api-gcp/static/;
	}
}
EOF

# remove default nginx config
sudo rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
# enable bucketlist-api-gcp instead
sudo ln -s /etc/nginx/sites-available/bucketlist-api-gcp /etc/nginx/sites-enabled/

echo 'restarting nginx'
sudo service nginx restart