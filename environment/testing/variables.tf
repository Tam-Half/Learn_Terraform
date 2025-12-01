variable "aws_region" {
    description = "AWS region to deploy"
    type = string
}

variable "aws_instance" {
  description = "EC2 instance type"
  type = string
}

variable "ami_id" {
    description = "AMI ID for EC2"
    type = string
}