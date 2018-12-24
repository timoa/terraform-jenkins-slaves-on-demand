#################
# Global
#################

variable "aws_region" {
  description = "Region where to deploy the Jenkins master and slaves"
  default = "us-east-1"
}

variable "env" {
  description = "Environment name to tag and suffix the infrastructure composants"
  default = "dev"
}

#################
# Network
#################

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet" {
  default = "10.0.1.0/24"
}

variable "private_subnet" {
  default = "10.0.2.0/24"
}

#################
# Instances
#################

variable "instance_type" {
  description = "Instance type for the Jenkins master"
  default = "t3.large"
}

variable "ebs_optimized" {
  description = "Indicates whether EBS optimization (additional, dedicated throughput between Amazon EC2 and Amazon EBS,) has been enabled for the instance."
  default = true
}

variable "path_public_key" {
  description = "Path to the Jenkins master public key"
  default = "jenkins-master-key.pub"
}

#################
# Storage
#################
