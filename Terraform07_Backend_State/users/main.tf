
terraform {
  backend "s3" {
    bucket = "ssit-backend-state-users-dev"
    key    = "backend-state/users/dev.tfstate"
    region = "ap-south-2"
    use_lockfile = true
    encrypt = true
  }
}

provider "aws" {
  region = "ap-south-2"
}

# Creating a iam user
resource "aws_iam_user" "sathishsekarit_iam_internal_user_one" {
  name = "sathishsekarit_iam_user_one"
}

