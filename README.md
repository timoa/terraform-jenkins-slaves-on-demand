# (WIP) Terraform template to create a Jenkins master with slaves on-demand

Configuration of a Jenkins master with slaves on-demand (AWS EC2 only for now).

## Includes

### Network

* Custom AWS Virtual Private Cloud (VPC)
* Subnet with the Jenkins master + Internet gateway (public IP)
* Subnet where the Jenkins slaves are launched (not exposed to Internet)

### Storage

* AWS Elastic File System (EFS) for the Jenkins master configuration and data

### Jenkins Master

* AWS EC2 template
* AWS AMI
* NGINX reverse-proxy configuration

### Jenkins Slaves

* AWS EC2 templates (different instance sizes)
* AWS AMI (minimal)