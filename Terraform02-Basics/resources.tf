variable "iam_user_name_prefix" {
  type    = string
  default = "sathishsekarit_iam_user"
}


# Creating a iam user
resource "aws_iam_user" "sathishsekarit_iam_internal_users" {
  count = 1
  name  = "${var.iam_user_name_prefix}_${count.index}"
}

