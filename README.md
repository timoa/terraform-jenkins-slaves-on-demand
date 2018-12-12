# (WIP) Terraform template to create a Jenkins master with slaves on-demand

Configuration of a Jenkins master with slaves on-demand (AWS EC2 only for now).

This template includes:

* Custom AWS Virtual Private Cloud (VPC)
* Subnet with the Jenkins master + Internet gateway (public IP)
* Subnet where the Jenkins slaves are launched (not exposed to Internet)
* AWS Elastic File System (EFS) for the Jenkins master configuration and data
* AWS AMI for the Jenkins server
* AWS AMI (minimal) for the Jenkins slaves
* AWS EC2 template for the Jenkins master
* AWS EC2 templates for the Jenkins slaves (different instance sizes)