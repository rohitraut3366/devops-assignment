# EC2 Instance
resource "aws_instance" "myec2_webserver" {
  ami                    = data.aws_ami.amz_linux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.sg-ssh.id, aws_security_group.sg-web.id]
  tags = {
    "Name" = "ec2-webserver"
  }
}
