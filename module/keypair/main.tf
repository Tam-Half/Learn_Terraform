# Create Private Key
resource "tls_private_key" "ssh_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

# Create AWS Key Pair

resource "aws_key_pair" "test" {
    key_name = var.key_name
    public_key = tls_private_key.ssh_key.public_key_openssh
}

# Export private key to file

resource "local_file" "private_key_pem" {
    content = tls_private_key.ssh_key.private_key_pem
    filename = "${path.module}/${var.key_name}.pem"
}
