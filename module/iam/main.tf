# IAM ROLE WOKER NODE
###
resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "eks-node-role"
  }
}

# Create Attach the AmazonEKSWokerNodePolicy 
# U can using EC2 join in EKS_Cluster 
# Communicate with Control Plane Node

resource "aws_iam_role_policy_attachment" "node_woker_policy_attachment" {
    role = aws_iam_role.eks_node_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Create Attach the AmazonWokerNode_CNI_Policy
# Kubernetes provider Ip for Pods - When Pods start in Woker node
# Handle Network for pod

resource "aws_iam_role_policy_attachment" "node_woker_cni_policy_attachment" {
    role = aws_iam_role.eks_node_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# Create Attach the AmazonAccept_PullImageFromECR (Elastic Container Registry) ( 0 or 1 )

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
    role = aws_iam_role.eks_node_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


# Create Instance Profile 
resource "aws_iam_instance_profile" "eks_woker_node_profile" {
    name = "eks-woker-node-profile"
    role = aws_iam_role.eks_node_role.name
}


# I AM ROLE EKS CLUSTER
###
resource "aws_iam_role" "cluster" {
  name = "eks-cluster-demo"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
    role = aws_iam_role.cluster.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  role = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}
