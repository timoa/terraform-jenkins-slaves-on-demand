# Latest Amazon Linux 2 AMI with SSD (GP2) uses for the Jenkins master
data "aws_ami" "amazon_linux_2" {
    most_recent = true

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

# Latest Amazon Linux 2 AMI minimal
data "aws_ami" "amazon_linux_2_minimal" {
    most_recent = true

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