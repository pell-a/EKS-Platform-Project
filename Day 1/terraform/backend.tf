terraform {
  backend "s3" {
    bucket = "{bucket_name}"
    key = "eks-platform/terraform.tfstate"
    region = "{region}"
    dynamodb_table = "{dynamodb_table_name}"
    encrypt = true
  }
}