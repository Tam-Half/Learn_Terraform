resource "aws_eks_cluster" "master_node" {
    name = "master_node"
    role_arn =  var.aws_iam_role_eks_cluster_arn
    version  = "1.33"

    kubernetes_network_config {
        service_ipv4_cidr = var.service_ipv4_cidr
    }

    vpc_config {
      subnet_ids = var.subnet_ids
      endpoint_private_access = false
      endpoint_public_access  = true
      public_access_cidrs     = ["0.0.0.0/0"]
    }

    depends_on = [var.aws_iam_role_eks_cluster_arn]
}