output "key_name" {
  value = aws_key_pair.test.key_name
}

output "private_key_path" {
  value = local_file.private_key_pem.filename
}
