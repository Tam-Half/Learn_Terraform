# resource "aws_eks_node_group" "demo" {
#     cluster_name = aws_eks_cluster.master_node.name
#     node_group_name = "demo"
#     node_role_arn = var.aws_eks_woker_node_profile
#     subnet_ids  = var.private_subnets
#   scaling_config {
#     desired_size = 1
#     max_size = 3
#     min_size = 1
#   }

#   update_config {
#     max_unavailable = 1
#   }

#   depends_on = [var.aws_eks_woker_node_profile]
# }