aws_region              = "us-east-1"
eks-cluster             = "a1vincent-eks-cluster"
eks-cluster-version     = "1.28"
endpoint_private_access = false
endpoint_public_access  = true
aws_iam_role_name       = "eks_iam_role"
name                    = "eks-node-groups"
desired_size            = 1
max_size                = 1
min_size                = 1
ami_type                = "AL2_x86_64"
capacity_type           = "ON_DEMAND"
disk_size               = 20
force_update_version    = false
instance_types          = ["t3.small"]

tags = {
  id             = "2024"
  owner          = "a1vincent"
  teams          = "practical"
  environment    = "dev"
  project        = "eks-node-groups"
  create_by      = "Terraform"
  cloud_provider = "aws"
}

public_subnet_ids = [
  "subnet-03c4774966de88882",
  "subnet-02c367ae2d29ea05c",
  "subnet-0695816369a036fda"
]

private_subnet_ids = [
  "subnet-0cb5ba155f5877454",
  "subnet-0ea37f876404e5c7e",
  "subnet-05b1cf6b2cb80dce3"
]


