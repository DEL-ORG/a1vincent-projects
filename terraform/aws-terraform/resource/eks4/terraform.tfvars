aws_region              = "us-east-1"
name                    = "eks-cluster"
eks-cluster             = "a1vincent_eks_cluster"
eks-cluster-version     = "1.28"
endpoint_private_access = false
endpoint_public_access  = true

tags = {
  "id"             = "2024"
  "owner"          = "a1vincent"
  "teams"          = "practical"
  "environment"    = "dev"
  "project"        = "eks"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}

subnet_ids = [
  "subnet-065127e56675202bd",
  "subnet-0f9576a8de0990bd2",
  "subnet-0aaa229314889fac7"
]

