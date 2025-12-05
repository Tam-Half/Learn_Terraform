variable "aws_instance_type" {
    type = string
    description = "Instance Type of EC2"
}

variable "aws_instance_name" {
    type = string
    description = "Name of EC2"
}

variable "aws_ami_id" {
    type = string
    description = "AM ID of Instance EC2"
}

variable "key_name" {
    type = string
    description = "Name of keypari for sshopen"
  
}

variable "public_subnet" {
    type = list(string)
    description = "Public Subnet of EC2"
  
}
variable "vpc_id" {
    type = string
    description = "VPC ID" 
}

variable "allowed_ssh_ips" {
    description = "My Ip SSH to EC2"
    type = list(string)
    #["MY IP"]
    # curl ifconfig.me
    default = []
}

variable "instance_profile" {
    description = "Role arn for woker node eks"
    type = string
}

variable "aws_eks_cluster" {
    description = "Name EKS Cluster connect EC2 bootstrap"
    type = string
}

variable "aws_eks_cluster_endponit" {}
variable "aws_eks_cluster_auth" {}