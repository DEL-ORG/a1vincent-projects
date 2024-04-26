# Data source to fetch information about private subnets
data "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_ids)

  filter {
    name   = "tag:Name"
    values = [var.private_subnet_ids[count.index]]
  }
}

# # Data source to fetch information about subnets
# data "aws_subnet" "subnets" {
#   count = length(var.subnet_ids)

#   filter {
#     name   = "tag:Name"
#     values = [var.subnet_ids[count.index]]
#   }
# }

# data "aws_public_subnet" "public_subnet" {
#   name = "2024-vincent_public_subnet-1"
# }

# data "aws_public_subnet" "public_subnet" {
#   name = "2024-vincent_public_subnet-2"
# }

# data "aws_private_subnet" "private_subnet" {
#   name = "2024-vincent_private_subnet-0"
# }

# data "aws_private_subnet" "private_subnet" {
#   name = "2024-vincent_private_subnet-1"
# }

# data "aws_private_subnet" "private_subnet" {
#   name = "2024-vincent_private_subnet-2"
# }
