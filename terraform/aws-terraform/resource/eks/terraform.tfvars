aws_region              = "us-east-1"
cluster_name            = "eks"
node_group_name         = "dev"
sg_ids                  = "sg-0e461ce5b34f76059"
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
  "subnet-02adcc2305b34bbc8",
  "subnet-06af1ca8b7eb2a9b1",
  "subnet-064e788b552bf7a07"
]

subnet_ids = [
  "subnet-0664e238d971b4a8e",
  "subnet-077c09f3ebf21492a",
  "subnet-012216369ad5342c9",
]
