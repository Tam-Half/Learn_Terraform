output "ec2_public_ip" {
    value = aws_instance.node_woker[*].public_ip
}

output "ec2_ids" {
  value = aws_instance.node_woker[*].id
}
