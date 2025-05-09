# output "subnet_ids" {
#   description = "List of IDs of the created subnets"
#   value       = aws_subnet.this[*].id
# }

# output "subnet_arns" {
#   description = "List of ARNs of the created subnets"
#   value       = aws_subnet.this[*].arn
# }

# output "subnet_cidr_blocks" {
#   description = "List of CIDR blocks of the created subnets"
#   value       = aws_subnet.this[*].cidr_block
# }

# output "subnet_availability_zones" {
#   description = "List of availability zones of the created subnets"
#   value       = aws_subnet.this[*].availability_zone
# }

# output "subnet_ids_by_az" {
#   description = "Map of availability zones to subnet IDs"
#   value = {
#     for subnet in aws_subnet.this :
#       subnet.availability_zone => subnet.id
#   }
# }

# output "subnet_cidr_blocks_by_az" {
#   description = "Map of availability zones to subnet CIDR blocks"
#   value = {
#     for subnet in aws_subnet.this :
#       subnet.availability_zone => subnet.cidr_block
#   }
# }

# output "vpc_id" {
#   description = "The VPC ID where the subnets were created"
#   value       = var.vpc_id
# }

# output "subnet_count" {
#   description = "Number of subnets created"
#   value       = var.subnet_count
# }