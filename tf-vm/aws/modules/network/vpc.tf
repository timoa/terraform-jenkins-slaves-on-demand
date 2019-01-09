/**
 * Usage:
 *
 * module "instance" {
 *   source = "./modules/network"
 *   
 *   # Global
 *   aws_region        = "${var.aws_region}"
 *   env               = "${var.env}"
 *   
 *   # VPC
 *   vpc_cidr          = "${var.vpc_cidr}"
 *   public_subnet     = "${var.public_subnet}"
 *   private_subnet    = "${var.private_subnet}"
 *
 * }
 */
 
variable "aws_region" {}
variable "env" {}
variable "vpc_cidr" {}
variable "public_subnet" {}
variable "private_subnet" {}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc-${var.env}"
  cidr = "${var.vpc_cidr}"

  azs             = ["${var.aws_region}a"]
  public_subnets  = ["${var.public_subnet}"]
  private_subnets = ["${var.private_subnet}"]
  
  enable_dns_hostnames = true
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

  # Tags
  tags = {
    Terraform   = "true"
    Environment = "${var.env}"
  }
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

output "public_subnets" {
  description = "ID of the VPC public subnet"
  value       = ["${module.vpc.public_subnets}"]
}

output "private_subnets" {
  description = "ID of the VPC private subnet"
  value       = ["${module.vpc.private_subnets}"]
}