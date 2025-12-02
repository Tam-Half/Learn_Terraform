######################
#0. LOCAL
######################
module "key_pair" {
    source = "../../module/keypair"
    key_name = "ec2_key_ssh"
}

######################
#1. AMI
######################

module "iam" {
    source = "../../module/iam"
    region = var.aws_region
}
######################
#2.VPC
######################
module "vpc" {
    source = "../../module/vpc"
    aws_name_vpc = "my_vpc"
    public_azs = ["ap-southeast-1a", "ap-southeast-1b"]
}

######################
#3.EC2
######################
module "name" {
    source = "../../module/ec2"
    aws_ami_id = var.ami_id
    aws_instance_type = var.instance_type
    aws_instance_name = "ec2_terraform_test"
    key_name = module.key_pair.key_name
    public_subnet = module.vpc.public_subnet_ids
    vpc_id = module.vpc.vpc_id
}
