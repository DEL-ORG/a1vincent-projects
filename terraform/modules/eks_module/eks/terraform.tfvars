aws_region              = "us-east-1"
cluster_name            = "eks"
node_group_name         = "dev"
sg_ids                  = "sg-0dc47ff9f077ab787"
cluster-version         = "1.28"
endpoint_private_access = false
endpoint_public_access  = true
desired_size            = 2
max_size                = 3
min_size                = 1
max_unavailable         = 1
ami_type                = "AL2_x86_64"
capacity_type           = "ON_DEMAND"
disk_size               = 20
force_update_version    = false
instance_types          = ["t3.small"]

tags = {
  "id"             = "2024"
  "owner"          = "a1vincent"
  "teams"          = "practical"
  "environment"    = "dev"
  "project"        = "eks"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}

private_subnet_ids = [
  "subnet-0508566a2b4386be4",
  "subnet-04b75c11686adb0af",
  "subnet-0441c14b0aaf16325"
]

subnet_ids = [
  "subnet-0fd0fd2e8aeb61428",
  "subnet-019c6427c1f8e7efe",
  "subnet-0e0e8dbbbfab39bbf",
]


