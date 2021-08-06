resource "aws_launch_template" "asg_template" {
  depends_on = [aws_ami_from_instance.nginx-wordpress]
  name_prefix   = var.prefix
  image_id      = aws_ami_from_instance.nginx-wordpress.id
  instance_type = var.asg_template_instance_type
  vpc_security_group_ids = [module.instance_sg.security_group_id]
  key_name = var.instance_keypair
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ec2-webserver"
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity   = var.asg_desired_capacity
  max_size           = var.asg_max_capacity
  min_size           = var.asg_min_capacity
  vpc_zone_identifier = data.aws_subnet_ids.subnets.ids
  target_group_arns = module.wordpress_alb.target_group_arns

  launch_template {
    id      = aws_launch_template.asg_template.id
    version = "$Latest"
  }
}
