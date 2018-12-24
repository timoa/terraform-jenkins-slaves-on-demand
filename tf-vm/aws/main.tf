module "network" {
  source = "./modules/network"
  env = "${var.env}"
  aws_region = "${var.aws_region}"
  vpc_cidr = "${var.vpc_cidr}"
  public_subnet = "${var.public_subnet}"
  private_subnet = "${var.private_subnet}"
}

module "instances" {
  source = "./modules/instances"
  env = "${var.env}"
  vpc_id = "${module.network.vpc_id}"
  public_subnets = "${module.network.public_subnets}"
  security_group_id = "${module.network.jenkins_master_sg_id}"
  instance_type = "${var.instance_type}"
  ebs_optimized = "${var.ebs_optimized}"
  path_public_key = "${var.path_public_key}"
}
