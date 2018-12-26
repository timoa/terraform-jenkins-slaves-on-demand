module "network" {
  source = "./modules/network"

  # Global
  env = "${var.env}"
  aws_region = "${var.aws_region}"

  # VPC
  vpc_cidr = "${var.vpc_cidr}"
  public_subnet = "${var.public_subnet}"
  private_subnet = "${var.private_subnet}"
}

module "instances" {
  source = "./modules/instances"

  # Global
  env = "${var.env}"

  # Network
  vpc_id = "${module.network.vpc_id}"
  public_subnets = "${module.network.public_subnets}"

  # Instance
  security_group_id = "${module.network.jenkins_master_sg_id}"
  instance_type = "${var.instance_type}"
  ebs_optimized = "${var.ebs_optimized}"
  path_public_key = "${var.path_public_key}"
}
