resource "aws_kms_key" "jenkins_kms_key" {
	description = "KMS key to encrypt disk (root/efs volumes) for the ${var.env} environment"
	  tags {
		  Terraform    = "true"
      Name         = "jenkins-kms-${var.env}"
      Environmnent = "${var.env}"
	  }
}

resource "aws_kms_alias" "key" {
  name          = "alias/jenkins"
  target_key_id = "${aws_kms_key.jenkins_kms_key.key_id}"
}