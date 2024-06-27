variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "owner"          = "a1vincent"
    "teams"          = "practical"
    "environment"    = "dev"
    "project"        = "worker-nodes"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

variable "cluster-version" {
  type    = string
  default = "1.28"
}

variable "cluster_name" {
  type    = string
  default = "control-plane"
}

variable "node_min" {
  type    = string
  default = "1"
}

variable "desired_node" {
  type    = string
  default = "1"
}

variable "node_max" {
  type    = string
  default = "6"
}

variable "node_group_name" {
  type    = string
  default = "dev"
}

variable "sg_ids" {
  type    = string
  default = "sg-0dc47ff9f077ab787"
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
  type        = string
  description = "Valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64"
  default     = "AL2_x86_64"
}

variable "capacity_type" {
  type        = string
  description = "Valid values: ON_DEMAND, SPOT"
  default     = "ON_DEMAND"
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

variable "blue_node_color" {
  type    = string
  default = "blue"
}

variable "ec2_ssh_key" {
  type        = string
  description = "SSH key to connect to the node from bastion host"
  default     = "terraform"
}

variable "deployment_nodegroup" {
  type    = string
  default = "blue_green"
}

variable "control_plane_name" {
  type    = string
  default = "2024-dev-del"
}

variable "enable_cluster_autoscaler" {
  type        = string
  description = "Valid values are true or false"
  default     = "true"
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








