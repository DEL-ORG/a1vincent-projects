################################################################################
# Resource: aws_eks_worker_nodes

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.worker.arn
  subnet_ids      = values(var.private_subnet_ids)
  capacity_type   = var.capacity_type
  disk_size       = var.disk_size
  instance_types  = var.instance_types
  remote_access {
    ec2_ssh_key               = "devops-key"
    source_security_group_ids = [var.sg_ids]
  }

  tags = {
    "k8s.io/cluster-autoscaler/enabled" = "true"
  }

  labels = tomap({ env = "dev" })

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}




