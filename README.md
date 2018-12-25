# (WIP) Terraform template to create a Jenkins master with slaves on-demand

[![License: MIT][badge-license]][link-license]

Configuration of a Jenkins master with slaves on-demand (AWS EC2 only for now).

![Infrastructure diagram][image-infrastructure-diagram]

## Includes

### Network

#### Global

* Custom Virtual Private Cloud (VPC)

#### Jenkins master

* Public subnet
* Internet gateway
* NAT gateway
* Security group to allow access the Jenkins UI
* Security group to allow access to EFS storage from Jenkins master

#### Jenkins slaves

* Private subnet
* Security groups to allow only access from the Jenkins instance

### Instances

#### Jenkins Master

* AWS EC2 instance (t3.large by default)
* AWS AMI (Amazon Linux 2)
* SSH key pair
* NGINX reverse-proxy configuration

#### Jenkins Slaves

* AWS EC2 instance template (different instance sizes)
* AWS AMI (Amazon Linux 2 minimal)
* SSH key pair

### Storage

* EBS root volume for all instances
* AWS Elastic File System (EFS) for the Jenkins master configuration and data

## How to install

Clone this Git repository and go to the `tf-vm/aws` folder (only type and provider for the moment)

```bash
git clone git@github.com:timoa/terraform-jenkins-slaves-on-demand.git
cd terraform-jenkins-slaves-on-demand/tf-vm/aws
```

You can change some of the variables in the `variables.tf`. See the [configuration section](#configuration)

Start by install the dependencies

```bash
terraform init
```

Run `terraform plan` to see which resources will be created and save the generated execution plan

```bash
terraform plan --out=jenkins.tfplan
```

Apply the Terraform plan

```bash
terraform apply jenkins.tfplan
```

## Configuration

| Variable | Default value | Description |
|----------|---------------|-------------|
| aws_region | us-east-1 | AWS Region |
| env | dev | Name of the environment |
| vpc_cidr | 10.0.0.0/16 | VPC CIDR |
| public_subnet | 10.0.1.0/24 | Public subnet |
| private_subnet | 10.0.2.0/24 | Private subnet |
| instance_type | t3.large | Instance type |
| ebs_optimized | true | EBS optimized |
| path_public_key | jenkins-master-key.pub | Path to the SSH public key for Jenkins master |

## TODO

* Terraform backend with S3 + lock
* Mount the EFS volume (EFS creation can take 2 min)
* Create KMS key for encryption
* Encrypt EFS at rest + configure encryption in transit
* Encrypt root volume
* Install Jenkins (add repo + install)
* Configure Jenkins with the necessary plugins
* Create the EC2 slaves templates
* Elastic IP for Jenkins master
* Let's Encrypt SSL certificate for the Jenkins master
* Use an existing VPC ID
* Use an existing EFS ID

[badge-license]: https://img.shields.io/badge/License-MIT-blue.svg
[link-license]: https://raw.githubusercontent.com/timoa/terraform-jenkins-slaves-on-demand/master/LICENSE
[image-infrastructure-diagram]: https://github.com/timoa/terraform-jenkins-slaves-on-demand/raw/master/doc/images/diagram-jenkins-slaves-on-demand.png