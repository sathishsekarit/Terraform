variable "iam_user_names" {
  default = ["Sathish_Sekar", "Suresh"]
}

provider "aws" {
  region = "ap-south-2"
}


# The count will get the length of the "iam_user_names" list
# The names will be assigned based on the count index

# resource "aws_iam_user" "sathishsekarit_iam_internal_users" {
  
#   count = length(var.iam_user_names)
#   name  = var.iam_user_names[count.index]
# }


resource "aws_iam_user" "sathishsekarit_iam_internal_users" {
  for_each = toset(var.iam_user_names)
  name = each.value
}
