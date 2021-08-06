variable "aws_region" {
  description = "Region from where resources will be used"
  type = string
  default = "ap-south-1"
}

variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "instance_count" {
  description = "Number of instances"
  type = number
}

variable "instance_keypair"{
  description = "instance key name"
  type = string
}