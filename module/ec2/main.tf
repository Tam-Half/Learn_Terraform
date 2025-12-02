
resource "aws_instance" "app_server" {
  ami        = var.aws_ami_id
  instance_type = var.aws_instance_type
  associate_public_ip_address = true
  key_name = var.key_name
  subnet_id = var.public_subnet[0]

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = var.aws_instance_name
  }
}

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