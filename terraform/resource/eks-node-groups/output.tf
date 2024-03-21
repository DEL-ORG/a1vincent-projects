output "cluster_region" {
  value = var.aws_region
}

output "cluster_name" {
  value = var.name
}

output "cluster_tags" {
  value = var.tags
}

output "public_subnet_ids" {
  value = var.public_subnet_ids
}

output "private_subnet_ids" {
  value = var.private_subnet_ids
}
