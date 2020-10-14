provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "git::https://github.com/aashishgoyal246/terraform-aws-vpc.git?ref=tags/0.12.0"

  name        = "vpc"
  application = "aashish"
  environment = "test"
  label_order = ["environment", "application", "name"]

  enabled    = true
  cidr_block = "10.10.0.0/16"
}

module "security_group" {
  source = "../"

  name        = "security-group"
  application = "aashish"
  environment = "test"
  label_order = ["environment", "application", "name"]

  enabled       = true
  vpc_id        = module.vpc.vpc_id
  description   = "Security Group for SSH, WebServer."
  protocol      = "tcp"
  allowed_ip    = ["202.173.125.218/32", module.vpc.vpc_cidr_block]
  allowed_ports = [22, 80]
}