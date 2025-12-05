output "aws_iam_role_node_woker_arn" {
    description = "The ARN of EKS node IAM Role"
    value = aws_iam_role.eks_node_role.arn
}
#Admin
output "aws_iam_role_eks_cluster_arn" {
    value = aws_iam_role.cluster.arn
}

output "aws_iam_role_eks_cluster_name" {
    value = aws_iam_role.cluster.name
}

#Woker node
output "instance_profile_name" {
  value = aws_iam_instance_profile.eks_woker_node_profile.name
}

output "instance_profile_arn" {
  value = aws_iam_instance_profile.eks_woker_node_profile.arn
}