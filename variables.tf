#Module      : LABELS
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "application" {
  type        = string
  default     = ""
  description = "Application (e.g. `cd` or `clouddrove`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "enabled" {
  type        = bool
  default     = false
  description = "Flag to control the vpc creation."
}

variable "label_order" {
  type        = list
  default     = []
  description = "Label order, e.g. `name`,`application`."
}

variable "tags" {
  type        = map
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

#Module      : SECURITY GROUP
#Description : Terraform security group resource variables.
variable "vpc_id" {
  type        = string
  default     = ""
  description = "The ID of the VPC that the instance security group belongs to."
}

variable "description" {
  type        = string
  default     = ""
  description = "The security group description."
}

variable "allowed_ip" {
  type        = list
  default     = []
  description = "Lists of allowed IP."
}

variable "allowed_ports" {
  type        = list
  default     = []
  description = "Lists of allowed ports."
}

variable "ipv6_enabled" {
  type        = bool
  default     = false
  description = "Whether IPV6 is enabled or not."
}

variable "allowed_ipv6" {
  type        = list
  default     = []
  description = "Lists of allowed IPV6."
}

variable "protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number."
}