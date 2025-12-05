variable "subnet_ids" {
    description = "subnet ids for eks master"
    type = list(string)
}

variable "aws_iam_role_eks_cluster_arn" {
    type = string
}

# variable "aws_eks_woker_node_profile" {
#     type = string
# }

variable "service_ipv4_cidr" {
    type = string
    default = "172.20.0.0/16"
}

variable "private_subnets" {
    type = list(string)
}

