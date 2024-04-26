################################################################################
# Resource: aws_eks_worker_nodes

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.worker.arn
  subnet_ids      = var.private_subnet_ids
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


#####################################################################
# # role and permissions for eks-worker-nodes

# resource "aws_iam_role" "worker" {
#   name = format("%s-worker", var.tags["project"]) # The name of the role

#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.worker.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.worker.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#   role       = aws_iam_role.worker.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.worker.name
# }

#############################################################################################

# Resource: aws_eks_cluster
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster

# resource "aws_eks_cluster" "eks" {
#   name     = var.cluster_name
#   role_arn = aws_iam_role.master.arn

#   version = var.cluster-version

#   vpc_config {
#     endpoint_private_access = var.endpoint_private_access
#     endpoint_public_access  = var.endpoint_public_access
#     subnet_ids              = var.subnet_ids
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
#     aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
#     aws_iam_role_policy_attachment.AmazonEKSVPCResourceController
#   ]
# }

################################################################################
# Resource: aws_eks_worker_nodes

# resource "aws_eks_node_group" "node_group" {
#   cluster_name    = aws_eks_cluster.eks.name
#   node_group_name = var.node_group_name
#   node_role_arn   = aws_iam_role.worker.arn
#   subnet_ids      = var.private_subnet_ids
#   capacity_type   = var.capacity_type
#   disk_size       = var.disk_size
#   instance_types  = var.instance_types
#   remote_access {
#     ec2_ssh_key               = "devops-key"
#     source_security_group_ids = [var.sg_ids]
#   }

#   labels = tomap({ env = "dev" })

#   scaling_config {
#     desired_size = var.desired_size
#     max_size     = var.max_size
#     min_size     = var.min_size
#   }

#   update_config {
#     max_unavailable = var.max_unavailable
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy
#   ]
# }



# #########################
# # role and permissions for eks-cluster

# resource "aws_iam_role" "master" {
#   name = format("%s-master", var.tags["project"]) # The name of the role

#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "eks.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.master.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
#   role       = aws_iam_role.master.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
#   role       = aws_iam_role.master.name
# }

# #########################
# # role and permissions for eks-worker-nodes

# resource "aws_iam_role" "worker" {
#   name = format("%s-worker", var.tags["project"]) # The name of the role

#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "eks.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY
# }

# # resource "aws_iam_policy" "autoscaler" {
# #   name = format("%s-autoscaler-policy", var.tags["project"])

# #   policy = <<EOF
# # {
# #   "Version": "2012-10-17",
# #   "Statement": [
# #     {
# #       "Action": [
# #         "autoscaling:DescribeAutoScalingGroups", 
# #         "autoscaling:DescribeAutoScalingInstances",
# #         "autoscaling:DescribeTags",
# #         "autoscaling:DescribeLaunchConfiguration",
# #         "autoscaling:SetDesiredCapacity",
# #         "autoscaling:TerminateInstanceInAutoscalingGroup",
# #         "ec2:DescribeLaunchTemplateVersions",
# #       ],
# #       "Effect": "Allow",
# #       "Resource": "*"
# #     }
# #   ]
# # }
# # EOF
# # }

# resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.worker.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.worker.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#   role       = aws_iam_role.worker.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.worker.name
# }

# # resource "aws_iam_role_policy_attachment" "x-ray" {
# #   policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
# #   role       = aws_iam_role.worker.name
# # }

# # resource "aws_iam_role_policy_attachment" "s3" {
# #   policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
# #   role       = aws_iam_role.worker.name
# # }

# # resource "aws_iam_role_policy_attachment" "autoscaler" {
# #   policy_arn = aws_iam_policy.autoscaler.arn
# #   role       = aws_iam_role.worker.name
# # }

# # resource "aws_iam_instance_profile" "worker" {
# #   depends_on = [aws_iam_role.worker]
# #   name       = format("%s-worker-new-profile", var.tags["project"])
# #   role       = aws_iam_role.worker.name
# # }

# #############################################################################################

# # Resource: aws_eks_cluster
# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster

# resource "aws_eks_cluster" "eks" {
#   name     = var.cluster_name
#   role_arn = aws_iam_role.master.arn

#   version = var.cluster-version

#   vpc_config {
#     endpoint_private_access = var.endpoint_private_access
#     endpoint_public_access  = var.endpoint_public_access
#     subnet_ids              = [var.subnet_ids[0], var.subnet_ids[1]]
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
#     aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
#     aws_iam_role_policy_attachment.AmazonEKSVPCResourceController
#     # aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
#     # aws_subnet.pub_sub1,
#     # aws_subnet.pub_sub2,
#   ]
# }

# ################################################################################
# # Resource: aws_eks_worker_nodes

# resource "aws_eks_node_group" "node_group" {
#   cluster_name    = aws_eks_cluster.eks.name
#   node_group_name = var.node_group_name
#   node_role_arn   = aws_iam_role.worker.arn
#   subnet_ids      = [var.private_subnet_ids[0], var.private_subnet_ids[1]]
#   capacity_type   = var.capacity_type
#   disk_size       = var.disk_size
#   instance_types  = var.instance_types
#   remote_access {
#     ec2_ssh_key               = "devops-key"
#     source_security_group_ids = [var.sg_ids]
#   }

#   labels = tomap({ env = "dev" })

#   scaling_config {
#     desired_size = var.desired_size
#     max_size     = var.max_size
#     min_size     = var.min_size
#   }

#   update_config {
#     max_unavailable = var.max_unavailable
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,

#   ]
# }



