provider "aws" {
  region  = var.region
}

# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "s3-terraform-state" {
  bucket = format (var.tags["project"],"-terraform-state")

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = var.tags
}

# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "var.tags[project]}-terraform-lock"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.tags
}
