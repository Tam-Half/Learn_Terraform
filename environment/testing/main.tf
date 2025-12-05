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
    region = "ap-southeast-1"
}

# ######################
#2.VPC
######################
module "vpc" {
    source = "../../module/vpc"
    aws_name_vpc = "my_vpc"
    public_azs = ["ap-southeast-1a", "ap-southeast-1b"]
}

######################
#3.IAM_USERS
######################

module "iam_users" {
    source = "../../module/iam_users"
}

######################
#4.EKS_Cluster
######################
module "eks_cluster" {
    source = "../../module/eks"
    subnet_ids = module.vpc.public_subnet_ids
    aws_iam_role_eks_cluster_arn = module.iam.aws_iam_role_eks_cluster_arn
    private_subnets  = module.vpc.private_subnets_ids
}

######################
#5.EC2
######################
module "ec2_wokers" {
    source = "../../module/ec2"
    aws_ami_id = ""
    aws_instance_type = ""
    aws_instance_name = "ec2_terraform_test"
    key_name = module.key_pair.key_name
    public_subnet = module.vpc.public_subnet_ids
    vpc_id = module.vpc.vpc_id
    instance_profile = module.iam.instance_profile_name
    aws_eks_cluster = module.eks_cluster.cluster_name
    aws_eks_cluster_endponit = module.eks_cluster.cluster_endpoint
    aws_eks_cluster_auth = module.eks_cluster.kubeconfig_certificate_authority_data
}
