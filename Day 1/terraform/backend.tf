terraform {
  backend "s3" {
    bucket = "pella-eks-terraform-state"
    key = "eks-platform/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}