provider "aws" {
    region = var.aws_region
}

module "vpc" {
    source = "./vpc"
    vpc_cidr = var.vpc_cidr
    azs = var.azs
}