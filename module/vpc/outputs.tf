output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [
    aws_subnet.public_1a.id,
    aws_subnet.public_1b.id
  ]
}

output "private_subnets_ids" {
  value = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1b.id
  ]
}