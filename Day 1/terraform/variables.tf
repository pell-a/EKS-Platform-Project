variable "aws_region" {
    default = "{region}"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "azs" {
    default = ["{region}a", "{region}b"]

}