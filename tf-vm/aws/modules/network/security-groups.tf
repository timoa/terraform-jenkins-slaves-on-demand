module "jenkins_master_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-master-sg-${var.env}"
  description = "security group that allows Jenkins master access and all egress traffic"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Jenkins HTTP port"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Jenkins HTTPS port"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags {
    Terraform    = "true"
    Name         = "jenkins-master-sg-${var.env}"
    Environmnent = "${var.env}"
  }
}

module "jenkins_slaves_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-slaves-sg-${var.env}"
  description = "security group that allows Jenkins master access only and all egress traffic"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH from Jenkins master"
      cidr_blocks = "10.0.1.0/24"
    },
  ]

  tags {
    Terraform    = "true"
    Name         = "jenkins-slaves-sg-${var.env}"
    Environmnent = "${var.env}"
  }
}

output "jenkins_master_sg_id" {
  description = "ID of the Jenkins master security group"
  value       = "${module.jenkins_master_sg.this_security_group_id}"
}