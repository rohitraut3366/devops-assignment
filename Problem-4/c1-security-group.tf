module "instance_sg" {
  source              = "./modules/aws_security_group"
  security_group_name = "webserver-sg"
  vpc_id              = "vpc-8fc334e4"
  ingress = [{
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 22
      protocol    = "tcp"
      to_port     = 22
    },
  ]
}

module "rds_sg" {
  source = "./modules/aws_security_group"
  security_group_name = "rds_mysql_sg"
  vpc_id = "vpc-8fc334e4"
  ingress = [{
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 3306
    protocol    = "tcp"
    to_port     = 3306
    },
  ]
}

module "sg_alb" {
  source = "./modules/aws_security_group"
  security_group_name = "alb"
  vpc_id = "vpc-8fc334e4"
  ingress = [{
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    },
  ]
}