variable "aws_region" {}
variable "env" {}
variable "vpc_cidr" {}
variable "public_subnet" {}
variable "private_subnet" {}
variable "office_public_ip" {}

variable tags {
  type = "map"
}
