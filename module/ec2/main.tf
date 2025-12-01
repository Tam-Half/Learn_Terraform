

resource "aws_instance" "app_server" {
  ami           = "ami-00d8fc944fb171e29"
  instance_type = "t2.micro"

  tags = {
    Name = "learn-terraform-test"
  }
}