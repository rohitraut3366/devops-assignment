# AWS SG for webserver that allow HTTP 80 and SSH 22 port

resource "aws_security_group" "sg-web" {
  name        = "web"
  description = "Allow default web server port"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

  }

  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

# AWS SG for webserver that allow HTTP 80 and SSH 22 port
resource "aws_security_group" "sg-ssh" {
  name        = "SSH"
  description = "VPC SSH"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Port 80"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

  }

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
