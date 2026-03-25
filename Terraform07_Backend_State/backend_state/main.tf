provider "aws" {
  region = "ap-south-2"
}

resource "aws_s3_bucket" "ssit_backend_state" {
  bucket = "ssit-backend-state-users-dev"

  lifecycle {
    prevent_destroy = false
  }

}

resource "aws_s3_bucket_versioning" "ssit_versioning" {
  bucket = aws_s3_bucket.ssit_backend_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ssit_server_side_encryption" {
  bucket = aws_s3_bucket.ssit_backend_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "ssit_backend_lock" {
  name         = "ssit-dev-applications-backend-lock"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockId"

  attribute {
    name = "LockId"
    type = "S"
  }
}
