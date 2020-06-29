#Module      : SECURITY GROUP
#Description : This terraform module creates set of Security Group and Security Group Rules
#              resources in various combinations.
output "security_group_id" {
  value       = module.security_group.security_group_id
  description = "The ID of the security group."
}

output "tags" {
  value       = module.security_group.tags
  description = "A mapping of public tags to assign to the resource."
}