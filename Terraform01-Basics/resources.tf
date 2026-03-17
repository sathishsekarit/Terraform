resource "aws_s3_bucket" "cmdlineuser_internal_bucket" {
  bucket = "aws-cmdlineuser-s3-bucket"
}

resource "aws_s3_bucket_versioning" "cmdlineuser_internal_bucket_versioning" {
  bucket = aws_s3_bucket.cmdlineuser_internal_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Creating a iam user
resource "aws_iam_user" "sathishsekarit_iam_internal_user_one" {
  name = "sathishsekarit_iam_user_one"
}
