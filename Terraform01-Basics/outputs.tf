output "cmdlineuser_versioning_output" {
  value = aws_s3_bucket_versioning.cmdlineuser_internal_bucket_versioning.versioning_configuration[0].status
}

output "cmdlineuser_internal_bucket_details" {
  value = aws_s3_bucket.cmdlineuser_internal_bucket
}

output "sathishsekarit_iam_user_output" {
  value = aws_iam_user.sathishsekarit_iam_internal_user_one
}
