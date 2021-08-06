module "ec2_instance" {
  count              = var.instance_count
  source             = "./modules/aws_ec2_instance"
  instance_ami       = "ami-0c1a7f89451184c8b"
  security_group_ids = ["${module.instance_sg.security_group_id}"]
  instance_keypair   = var.instance_keypair
  subnet_id          = sort(data.aws_subnet_ids.subnets.ids)[count.index % 2]
  tags = {
    Name = "ec2-webserver"
  }
}

resource "aws_ami_from_instance" "nginx-wordpress" {
  depends_on = [
    null_resource.ansible_configuration
  ]
  name               = "nginx-wordpress"
  source_instance_id = module.ec2_instance[0].instance_id[0]
}