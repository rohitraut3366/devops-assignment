# AWS SG for webserver that allow HTTP 80 and SSH 22 port

resource "aws_security_group" "sg_web" {
  name        = "web"
  description = "Allow default web server port"

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-Webserver"
  }
}

# security group rule for HTTP port
resource "aws_security_group_rule" "http_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_web.id
}

# security group rule for HTTPS port
resource "aws_security_group_rule" "secure_http_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_web.id
}

# AWS SG for webserver that allow HTTP 80 and SSH 22 port
resource "aws_security_group" "sg_ssh" {
  name        = "SSH"
  description = "VPC SSH"

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-ssh"
  }
}

resource "aws_security_group_rule" "ssh_rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ssh.id
}

# RDS Security Group
resource "aws_security_group" "sg_mysql" {
  name        = "mysql"
  description = "VPC mysql"

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-mysql"
  }
}

resource "aws_security_group_rule" "mysql_rule" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_mysql.id
}

# Application Load Balancer Security Group
resource "aws_security_group" "sg_alb" {
  name        = "wordpress_alb"
  description = "Security Group for application loadbalancer"

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-wordpress-alb"
  }
}

resource "aws_security_group_rule" "alb_ingress_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_alb.id
}