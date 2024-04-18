provider "aws" {
  region = "us-east-1"
}

resource "aws_eks_cluster" "a1vincent_cluster" {
  name     = "a1vincent"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids         = ["subnet-1", "subnet-2", "subnet-3"] # Update with your subnet IDs
    security_group_ids = ["security-group-id"]                # Update with your security group ID
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.a1vincent_cluster.name
  node_group_name = "a1vincent-nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  subnet_ids = ["subnet-1", "subnet-2", "subnet-3"] # Update with your subnet IDs

  tags = {
    "k8s.io/cluster-autoscaler/enabled" = "true"
  }
}

resource "aws_iam_role" "eks_role" {
  name               = "a1vincent-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}

resource "aws_iam_role" "eks_node_role" {
  name               = "your-eks-node-role-name"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks_node_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

