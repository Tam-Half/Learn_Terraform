output "instance_public_ip" {
    description = "IP Public of EC2"
    value = "aws_instance."
}
output "aws_iam_role_node_woker_arn" {
  value = module.iam.aws_iam_role_node_woker_arn
}
output "cluster_name" {
    value = module.eks_cluster.cluster_name
}

output "auth_Test" {
  value = module.eks_cluster.kubeconfig_certificate_authority_data
}
output "endpoint_eks_cluster" {
  value = module.eks_cluster.cluster_endpoint
}