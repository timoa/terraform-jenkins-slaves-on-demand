#!/bin/bash -v

set -ex

# Refresh the Yum repositories and install updates
yum update -y

# Install Java 8 and cleanup older default version
yum install -y java-1.8.0
yum remove java-1.7.0-openjdk

# Install the latest Jenkins package
yum install -y jenkins

# TODO: Configure the path to /mnt/efs
# TODO: Pre-configure Jenkins

export JENKINS_URL="http://localhost:8080"
export JENKINS_USER_ID="ec2-user"
export JENKINS_API_TOKEN=$(cat /var/lib/jenkins/secrets/initialAdminPassword)

# Get the Jenkins CLI
wget $JENKINS_URL/jnlpJars/jenkins-cli.jar

# Install required plugins (ignore error if it failed)
java -jar jenkins-cli.jar install-plugin ec2-plugin || true
java -jar jenkins-cli.jar install-plugin greenballs || true

# Start Jenkins
service jenkins start

# Make Jenkins starts at boot
chkconfig --add jenkins
