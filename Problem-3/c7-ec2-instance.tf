# EC2 Instance

resource "aws_instance" "myec2_webserver" {
  ami                    = var.aws_instance_ami
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.sg_ssh.id, aws_security_group.sg_web.id]
  tags = {
    "Name" = "ec2-webserver"
  }
}

resource "aws_ami_from_instance" "nginx-wordpress" {
  depends_on = [
    null_resource.ansible_configuration
  ]
  name               = "nginx-wordpress"
  source_instance_id = aws_instance.myec2_webserver.id
}
