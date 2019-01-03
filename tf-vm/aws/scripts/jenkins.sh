#!/bin/bash -v

set -ex

# Install Java 8 and cleanup older default version
yum install -y java-1.8.0
yum remove java-1.7.0-openjdk

# Install the latest Jenkins package
yum install -y jenkins

# TODO: Configure the path to /mnt/efs
# TODO: Pre-configure Jenkins
# TODO: Install required plugins (EC2)

# Start Jenkins
service jenkins start

# Make Jenkins starts at boot
chkconfig --add jenkins
