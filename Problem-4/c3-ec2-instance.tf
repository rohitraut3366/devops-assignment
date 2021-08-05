module "ec2_instance" {
  count              = 4
  source             = "./modules/aws_ec2_instance"
  instance_ami       = "ami-0c1a7f89451184c8b"
  instance_count     = 4
  security_group_ids = ["${module.instance_sg.security_group_id}"]
  instance_keypair   = "devops"
  subnet_id          = sort(data.aws_subnet_ids.subnets.ids)[count.index % 2]
  tags = {
    Name = "ec2-webserver"
  }
}