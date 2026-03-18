# Creating map with values.
variable "iam_users" {
  default = {
    Sathish_Sekar : { country : "Bangalore", department : "Information Technology" },
    Suresh : { country : "Chennai", department : "Computer Science" }
  }
}

provider "aws" {
  region = "ap-south-2"
}

# We can iterate using for_each and the assigning the key for name
# We can also add a tag with name and assign the value to that specific tag.
resource "aws_iam_user" "sathishsekarit_iam_internal_users" {
  for_each = var.iam_users
  name     = each.key
  tags = {
    country : each.value.country
    department : each.value.department
  }
}
