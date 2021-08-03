# EC2 Instance Variables

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "instance_keypair" {
  description = "AWS EC2 Keypair that need to associate with aws instance"
  type        = string
  default     = "terraform-key"
}

variable "instance_count" {
  description = "Number of AWS EC2 Instances"
  type        = number
  default     = 1
}

variable "aws_instance_ami" {
  description = "AMI"
  type        = string
  default     = ""
}