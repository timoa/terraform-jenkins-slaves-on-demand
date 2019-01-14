/**
 * Usage:
 *
 * module "instance" {
 *   source = "./modules/instance"
 *   
 *   # Global
 *   aws_region        = "${var.aws_region}"
 *   env               = "${var.env}"
 *   
 *   # Network
 *   vpc_id            = "${module.network.vpc_id}"
 *   public_subnets    = "${module.network.public_subnets}"
 *   
 *   # Instance
 *   security_group_id = "${module.network.jenkins_master_sg_id}"
 *   instance_type     = "${var.instance_type}"
 *   ebs_optimized     = "${var.ebs_optimized}"
 *   path_public_key   = "${var.path_public_key}"
 *
 * }
 */

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

  # User data
  user_data = "${data.template_cloudinit_config.cloudinit-jenkins-master.rendered}"

  # Tags
  tags = "${merge(var.tags, map(
    "Name", "jenkins-master-ec2-${var.env}",
    "Environment", "${var.env}"
  ))}"
}
