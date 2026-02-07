variable "aws_region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "state-bucket-eks-platform"
}

variable "dynamodb_table" {
  default = "terraform-locks"
}