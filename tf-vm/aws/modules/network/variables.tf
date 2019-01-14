variable "aws_region" {}
variable "env" {}
variable "vpc_cidr" {}
variable "public_subnet" {}
variable "private_subnet" {}

variable tags {
  type = "map"
}
