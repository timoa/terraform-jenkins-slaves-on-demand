module "efs" {
  source = "git::https://github.com/cloudposse/terraform-aws-efs.git?ref=master"

  namespace  = "jenkins-master"
  stage      = var.env
  name       = ""
  attributes = ["efs"]

  aws_region         = var.aws_region
  vpc_id             = module.vpc.vpc_id
  subnets            = [module.vpc.public_subnets]
  availability_zones = ["${var.aws_region}a"]
  security_groups    = [module.jenkins_master_sg.this_security_group_id]

  encrypted = true

  # Tags
  tags = "${merge(var.tags, map(
    "Name", "jenkins-efs-${var.env}",
    "Environment", var.env
  ))}"
}
