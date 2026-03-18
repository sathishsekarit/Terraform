# Variable declaration is one of the methods we can pass value for the variables.
variable "iam_user_name_prefix" {
  type    = string
  default = "sathishsekarit_iam_user"
}


# Creating a iam user
# We can also export the variable value for the resource usage.
# Ex: export TF_VAR_iam_user_name_prefix=sathishsekarit_iam_user
resource "aws_iam_user" "sathishsekarit_iam_internal_users" {
  count = 1
  name  = "${var.iam_user_name_prefix}_${count.index}"
}

