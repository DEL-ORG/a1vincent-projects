# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "2024-dev-vpc-tf-state"
    dynamodb_table = "2024-dev-vpc-tf-state-lock"
    encrypt        = true
    key            = "./terraform.tfstate"
    region         = "us-east-1"
  }
}