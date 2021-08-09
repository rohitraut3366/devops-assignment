terraform {
  backend "s3" {
    bucket = "wordpress-terraform-remote-state"
    key    = "cr.tfstate"
    region = "ap-south-1"
    dynamodb_table = "tfstate-lock-table"
  } 
}