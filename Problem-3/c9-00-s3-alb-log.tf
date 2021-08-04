resource "aws_s3_bucket" "s3_alb_logs" {
  bucket = var.log_bucket_name
  acl    = var.bucket_acl
  force_destroy = var.force_destroy
  tags = {
    Name = "alb_logs"
  }
}