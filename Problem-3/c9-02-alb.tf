resource "aws_lb_target_group" "tga" {
  name     = "${var.target_group_name}-a"
  port     = var.service_port
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

resource "aws_lb_target_group_attachment" "tga_attachment" {
  target_group_arn = aws_lb_target_group.tga.arn
  target_id        = aws_instance.myec2_webserver[0].id
  port             = var.target_group_server_port
}

resource "aws_lb_target_group" "tgb" {
  name     = "${var.target_group_name}-b"
  port     = var.service_port
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

resource "aws_lb_target_group_attachment" "tgb_attachment" {
  target_group_arn = aws_lb_target_group.tgb.arn
  target_id        = aws_instance.myec2_webserver[1].id
  port             = var.target_group_server_port
}

resource "aws_lb" "front_end" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.sg_alb.id]
  subnets = data.aws_subnet_ids.subnets.ids
  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.s3_alb_logs.bucket
    prefix  = var.logs_prefix
    enabled = true
  }

  tags = {
    Name = "alb"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tga.arn
  }
}

resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 100

  action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.tga.arn
        weight = 50
      }

      target_group {
        arn    = aws_lb_target_group.tgb.arn
        weight = 50
      }
    }
  }
  condition {
    path_pattern{
      values = ["*"]
    }
  }
}