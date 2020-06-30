provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "git::https://github.com/aashishgoyal246/terraform-aws-vpc.git?ref=tags/0.12.1"

  name        = "vpc"
  application = "aashish"
  environment = "test"
  label_order = ["environment", "application", "name"]

  enabled                          = true
  cidr_block                       = "10.10.0.0/16"
  assign_generated_ipv6_cidr_block = true
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
  allowed_ip    = ["49.36.131.84/32", module.vpc.vpc_cidr_block]
  allowed_ports = [22, 80]

  ipv6_enabled = true
  allowed_ipv6 = ["2405:201:5e00:36ff:1c86:48cf:e7c4:d74b/128", module.vpc.vpc_ipv6_cidr_block] 
}