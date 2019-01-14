variable "aws_region" {}
variable "env" {}
variable "vpc_id" {}
variable "security_group_id" {}
variable "instance_type" {}
variable "ebs_optimized" {}

variable tags {
  type = "map"
}

variable "public_subnets" {
  description = "Public subnet used for the Jenkins master"
  type        = "list"
}

variable "path_public_key" {}
