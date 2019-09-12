#################
# Official AMI encrypted
#################

resource "aws_ami_copy" "amzn2_encrypted_ami" {
  name              = "jenkins-master-ami-encrypted-${var.env}"
  description       = "Encrypted root ami based on ${data.aws_ami.amzn2.id} for the Jenkins master"
  source_ami_id     = data.aws_ami.amzn2.id
  source_ami_region = var.aws_region
  encrypted         = "true"

  # Tags
  tags = "${merge(var.tags, map(
    "Name", "jenkins-master-ami-encrypted-${var.env}",
    "Environment", var.env
  ))}"
}

#################
# Official AMI
#################

# Latest Amazon Linux 2 AMI with SSD (GP2)
data "aws_ami" "amzn2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

# Latest Amazon Linux 2 AMI minimal (For the Jenkins slaves)
data "aws_ami" "amzn2_minimal" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-minimal-hvm-*-x86_64-ebs",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}
