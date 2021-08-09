resource "aws_s3_bucket" "bucket" {
  bucket = "wordpress-terraform-remote-state"
  force_destroy = true
  versioning {
    enabled = true
  }
  tags = {
    Name        = "tfstate"
  }
}