#!/bin/bash -v

set -ex

# Create a tmp repository
mkdir /run/yum

# Download & install the EPEL Release RPM repository
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Enable the EPEL Release RPM repository
sudo yum-config-manager --enable epel

# Refresh (again) the Yum repositories and install updates if newer updates from EPEL Release
yum update -y

# Install the latest NGINX package
yum install -y nginx

# Get servername
SERVERNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
echo $SERVERNAME

# Configure NGINX
cat > /etc/nginx/conf.d/jenkins.conf <<EOF
upstream jenkins {
  server 127.0.0.1:8080 fail_timeout=0;
}

server {
  listen      80;
  server_name $SERVERNAME;

  # Logs
  access_log  /var/log/nginx/jenkins-access.log;
  error_log   /var/log/nginx/jenkins-error.log;

  # Reverse-proxy to Jenkins master
  location / {
      proxy_pass                      http://jenkins;
      #proxy_set_header Host           $host;
      #proxy_set_header X-Real-IP      $remote_addr;
      proxy_connect_timeout           300;
  }
}
EOF

# Start NGINX
service nginx start

# Make NGINX starts at boot
chkconfig nginx on

# Cleanup
rm -Rf /run/yum