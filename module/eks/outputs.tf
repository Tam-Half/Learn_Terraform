output "cluster_name" {
    value = aws_eks_cluster.master_node.name
}

output "cluster_endpoint" {
    value = aws_eks_cluster.master_node.endpoint
}

output "kubeconfig_certificate_authority_data" {
    value = aws_eks_cluster.master_node.certificate_authority[0].data
}