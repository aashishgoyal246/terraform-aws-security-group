#Module      : LABELS
#Description : This terraform module is designed to generate consistent label names and tags
#              for resources. You can use terraform-labels to implement a strict naming
#              convention.
module "labels" {
  source = "git::https://github.com/aashishgoyal246/terraform-labels.git?ref=tags/0.12.0"

  name        = var.name
  application = var.application
  environment = var.environment
  enabled     = var.enabled
  label_order = var.label_order
  tags        = var.tags
}

#Module      : SECURITY GROUP
#Description : Here are an example of how you can use this module in your inventory
#              structure:
resource "aws_security_group" "default" {
  count       = var.enabled ? 1 : 0
  name        = module.labels.id
  vpc_id      = var.vpc_id
  description = var.description
  tags        = module.labels.tags
}

#Module      : SECURITY GROUP RULE FOR INGRESS
#Description : Provides a security group rule resource. Represents a single ingress
#              group rule, which can be added to external Security Groups.
resource "aws_security_group_rule" "ingress" {
  count             = var.enabled && length(var.allowed_ip) > 0 ? length(compact(var.allowed_ports)) : 0
  type              = "ingress"
  cidr_blocks       = var.allowed_ip
  ipv6_cidr_blocks  = var.ipv6_enabled ? var.allowed_ipv6 : []
  from_port         = element(var.allowed_ports, count.index)
  to_port           = element(var.allowed_ports, count.index)
  protocol          = var.protocol
  security_group_id = join("", aws_security_group.default.*.id)
}

#Module      : SECURITY GROUP RULE FOR EGRESS
#Description : Provides a security group rule resource. Represents a single egress
#              group rule, which can be added to external Security Groups.
resource "aws_security_group_rule" "egress" {
  count             = var.enabled && length(var.allowed_ip) > 0 ? 1 : 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = var.ipv6_enabled ? ["::/0"] : []
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = join("", aws_security_group.default.*.id)
}