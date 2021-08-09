data "aws_ami" "wordpress" {
  depends_on = [
    null_resource.packer_build
  ]
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name = "tag:Name"
    values = [ "Wordpress-1" ]

  }
}

data "aws_subnet_ids" "subnets" {
  vpc_id = var.vpc_id
}