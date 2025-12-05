
resource "aws_security_group" "ec2_sg" {
  name = "ec2-ssh-sg"
  description = "Allow SSH inbound traffic"
  vpc_id = var.vpc_id

  #
  ingress {
    description = "SSH from my IP"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.allowed_ssh_ips
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-ssh-security-group"
  }
}