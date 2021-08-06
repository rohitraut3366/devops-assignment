module "wordpress_alb" {
  depends_on = [
    module.sg_alb
  ]
  source    = "./modules/aws_alb"
  create_lb = true

  name        = "webserver-alb"
  name_prefix = "wordpress"
  vpc_id           = var.vpc_id
  load_balancer_type = "application"
  internal           = false
  security_groups    = [module.sg_alb.security_group_id]
  subnets            = data.aws_subnet_ids.subnets.ids

  idle_timeout                     = 60
  enable_cross_zone_load_balancing = true
  enable_deletion_protection       = false

  tags = {
      Name = "Wordpress Application Load Balancer"
  }

  target_groups = [
      {
          name = "wordpress-tg-a"
          backend_protocol = "HTTP"
          backend_port = 80
          target_type = "instance"
      },
      {
          name = "wordpress-tg-b"
          backend_protocol = "HTTP"
          backend_port = 80
          target_type = "instance"
      }
  ]
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = module.wordpress_alb.lb_arn[0]
  port              = 80
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = module.wordpress_alb.target_group_arns[0]
  }
}

resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 100

  action {
    type = "forward"
    forward {
      target_group {
        arn    = module.wordpress_alb.target_group_arns[0]
        weight = 100/length(module.wordpress_alb.target_group_arns)
      }
      target_group {
        arn    = module.wordpress_alb.target_group_arns[1]
        weight = 100/length(module.wordpress_alb.target_group_arns)
      }
    }
  }
  condition {
    path_pattern{
      values = ["*"]
    }
   } 
}
