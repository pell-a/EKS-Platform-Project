variable "aws_region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "pella-eks-terraform-state"
}

variable "dynamodb_table" {
  default = "terraform-locks"
}