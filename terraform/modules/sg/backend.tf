terraform {
  backend "s3" {
    bucket         = "2024-dev-tf-state"
    dynamodb_table = "2024-dev-tf-state-lock"
    key            = "sg/terraform.tfstate" #state file name
    region         = "us-east-1"
  }
}