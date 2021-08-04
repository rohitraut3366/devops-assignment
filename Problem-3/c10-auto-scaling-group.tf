resource "aws_launch_template" "asg_template" {
  name_prefix   = var.prefix
  image_id      = var.asg_template_image_id
  instance_type = var.asg_template_instance_type
  vpc_security_group_ids = [aws_security_group.sg_ssh.id, aws_security_group.sg_web.id]
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
  target_group_arns = [aws_lb_target_group.tga.arn, aws_lb_target_group.tgb.arn]

  launch_template {
    id      = aws_launch_template.asg_template.id
    version = "$Latest"
  }
}
