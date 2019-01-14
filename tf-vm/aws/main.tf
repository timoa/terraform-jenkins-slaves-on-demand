module "network" {
  source = "./modules/network"

  # Global
  aws_region = "${var.aws_region}"
  env        = "${var.env}"

  # VPC
  vpc_cidr       = "${var.vpc_cidr}"
  public_subnet  = "${var.public_subnet}"
  private_subnet = "${var.private_subnet}"

  tags = "${var.tags}"
}

module "instance" {
  source = "./modules/instance"

  # Global
  aws_region = "${var.aws_region}"
  env        = "${var.env}"

  # Network
  vpc_id         = "${module.network.vpc_id}"
  public_subnets = "${module.network.public_subnets}"

  # Instance
  security_group_id = "${module.network.jenkins_master_sg_id}"
  instance_type     = "${var.instance_type}"
  ebs_optimized     = "${var.ebs_optimized}"
  path_public_key   = "${var.path_public_key}"

  tags = "${var.tags}"
}
