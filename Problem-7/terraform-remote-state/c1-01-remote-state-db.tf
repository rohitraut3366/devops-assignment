resource "aws_dynamodb_table" "tf_lock_dynamodb_table" {
  name           = "tfstate-lock-table"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}