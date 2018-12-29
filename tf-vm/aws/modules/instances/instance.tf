

# Configurable variables from the environment folder
variable "aws_region" {}
variable "env" {}
variable "vpc_id" {}
variable "security_group_id" {}
variable "instance_type" {}
variable "ebs_optimized" {}

variable "public_subnets" {
  description = "Public subnet used for the Jenkins master"
  type = "list"
}

variable "path_public_key" {}

resource "aws_key_pair" "jenkins-master-keypair" {
  key_name   = "jenkins-master-keypair-${var.env}"
  public_key = "${file("${path.root}/${var.path_public_key}")}"
}

module "jenkins_master_ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  instance_count = 1

  name                        = "jenkins-master-ec2-${var.env}"
  ami                         = "${aws_ami_copy.amzn2_encrypted_ami.id}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${var.public_subnets[0]}"
  vpc_security_group_ids      = ["${var.security_group_id}"]
  associate_public_ip_address = true
  ebs_optimized               = "${var.ebs_optimized}"

  # Public SSH key
  key_name = "${aws_key_pair.jenkins-master-keypair.key_name}"

  # user data
  user_data = "${data.template_cloudinit_config.cloudinit-jenkins-master.rendered}"

  # Metadata
  tags {
    Terraform    = "true"
    Name         = "jenkins-master-ec2-${var.env}"
    Environmnent = "${var.env}"
  }

}

output "instance_id" {
  description = "EC2 instance ID"
  value       = "${module.jenkins_master_ec2.id[0]}"
}

output "instance_public_ip" {
  description = "Public IP assigned to the EC2 instance"
  value       = "${module.jenkins_master_ec2.public_ip[0]}"
}

output "instance_public_dns" {
  description = "Public DNS assigned to the EC2 instance"
  value       = "${module.jenkins_master_ec2.public_dns[0]}"
}

output "instance_az" {
  description = "Availability Zone where the EC2 instance is running"
  value       = "${module.jenkins_master_ec2.availability_zone}"
}