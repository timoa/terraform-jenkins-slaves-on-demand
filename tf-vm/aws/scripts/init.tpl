#cloud-config

repo_update: true
repo_upgrade: all

yum_repos:
  jenkins:
    name: Jenkins official repository
    baseurl: http://pkg.jenkins.io/redhat
    enabled: true
    failovermethod: priority
    gpgcheck: true
    gpgkey: https://pkg.jenkins.io/redhat/jenkins.io.key

packages:
  - amazon-efs-utils

# timezone: set the timezone
timezone: UTC

final_message: "System boot (via cloud-init) is COMPLETE, after $UPTIME seconds. Finished at $TIMESTAMP"

output:
  all: '| tee -a /var/log/cloud-init-output.log'
