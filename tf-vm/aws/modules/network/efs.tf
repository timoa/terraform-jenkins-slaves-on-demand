module "efs" {
  source     = "git::https://github.com/cloudposse/terraform-aws-efs.git?ref=master"
  
  namespace  = "jenkins-master"
  stage      = "${var.env}"
  name       = ""
  attributes = ["efs"]

  aws_region         = "${var.aws_region}"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = ["${module.vpc.public_subnets}"]
  availability_zones = ["${var.aws_region}a"]
  security_groups    = ["${module.jenkins_master_sg.this_security_group_id}"]

  encrypted          = true
}

output "efs_id" {
  description = "ID of the EFS volume"
  value       = "${module.efs.id}"
}

output "efs_host" {
  description = "Host name of the EFS volume"
  value       = "${module.efs.host}"
}

output "efs_mount_target_ids" {
  description = "Mount target IDS of the EFS volume"
  value       = "${module.efs.mount_target_ids}"
}

output "efs_mount_target_ips" {
  description = "Mount target IPs of the EFS volume"
  value       = "${module.efs.mount_target_ips}"
}