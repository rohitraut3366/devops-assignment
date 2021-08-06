resource "aws_iam_role" "test_role" {
  name = "test_role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17", 
    "Statement": [{ 
        "Effect": "Allow", 
        "Action": "ec2:DescribeInstances", 
        "Resource": "*" }]
  })
  tags = {
    tag-key = "tag-value"
  }
}
