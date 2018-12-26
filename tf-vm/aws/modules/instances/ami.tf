data "aws_ami" "amazon_linux_2" {
    description = "Latest Amazon Linux 2 AMI with SSD (GP2) uses for the Jenkins master"
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

data "aws_ami" "amazon_linux_2_minimal" {
    description = "Latest Amazon Linux 2 AMI"
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