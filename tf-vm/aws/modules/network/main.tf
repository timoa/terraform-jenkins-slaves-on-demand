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
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc-${var.env}"
  cidr = "${var.vpc_cidr}"

  azs             = ["${var.aws_region}a"]
  public_subnets  = ["${var.public_subnet}"]
  private_subnets = ["${var.private_subnet}"]

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_vpn_gateway   = false

  # Tags
  tags = "${merge(var.tags, map(
    "Name", "jenkins-vpc-${var.env}",
    "Environment", "${var.env}"
  ))}"
}

module "jenkins_master_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-master-sg-${var.env}"
  description = "Security group that allows Jenkins master access and all egress traffic"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      description = "Jenkins master HTTP port"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "https-443-tcp"
      description = "Jenkins master HTTPS port"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Internet"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  # Tags
  tags = "${merge(var.tags, map(
    "Name", "jenkins-master-sg-${var.env}"
  ))}"
}

module "jenkins_slaves_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-slaves-sg-${var.env}"
  description = "Security group that allows Jenkins master access only and all egress traffic"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      description = "SSH from Jenkins master"
      cidr_blocks = "${var.public_subnet}"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Internet"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  # Tags
  tags = "${merge(var.tags, map(
    "Name", "jenkins-slaves-sg-${var.env}",
    "Environment", "${var.env}"
  ))}"
}
