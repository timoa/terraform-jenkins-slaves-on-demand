provider "aws" {
  region  = var.aws_region
  version = "~> 2.7"
}

provider "template" {
  version = "~> 2.1"
}

provider "null" {
  version = "~> 2.1"
}