variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type    = string
  default = "control-plane"
}

variable "node_group_name" {
  type    = string
  default = "dev"
}

variable "sg_ids" {
  type    = string
  default = "sg-0dc47ff9f077ab787"
}

variable "cluster-version" {
  type    = string
  default = "1.28"
}

variable "endpoint_private_access" {
  type    = bool
  default = false
}

variable "endpoint_public_access" {
  type    = bool
  default = true
}

variable "desired_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 3
}

variable "min_size" {
  type    = number
  default = 1
}

variable "max_unavailable" {
  type    = number
  default = 1
}

variable "ami_type" {
  type    = string
  default = "AL2_x86_64"
}

variable "capacity_type" {
  type    = string
  default = "ON_DEMAND"
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "force_update_version" {
  type    = bool
  default = false
}

variable "instance_types" {
  type    = list(string)
  default = ["t3.small"]
}

variable "tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "owner"          = "a1vincent"
    "teams"          = "practical"
    "environment"    = "dev"
    "project"        = "eks"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

variable "private_subnet_ids" {
  type = list(string)
  default = [
    "subnet-0508566a2b4386be4",
    "subnet-04b75c11686adb0af",
    "subnet-0441c14b0aaf16325"
  ]
  description = "list of private subnet IDs"
}

variable "subnet_ids" {
  type = list(string)
  default = [
    "subnet-0fd0fd2e8aeb61428",
    "subnet-019c6427c1f8e7efe",
    "subnet-0e0e8dbbbfab39bbf",
  ]
  description = "list of public subnet IDs"
}

# variable "aws_iam_role_name" {
#   type    = string
#   default = "eks_iam_role"
# }

# variable "name" {
#   type    = string
#   default = "eks-node-groups"
# }





#Assuming you already have subnet IDs, you can define them as variables
# variable "public_subnet_ids" {
#   type = list(string)
#   default = [
#     "subnet-03c4774966de88882",
#     "subnet-02c367ae2d29ea05c",
#     "subnet-0695816369a036fda"
#   ]
#   description = "list of public subnet IDs"
# }








