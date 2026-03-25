data "aws_subnets" "ssit_default_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.ssit_default_vpc.id]
  }
}

data "aws_ami" "ssit_aws_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.10.20260302.1-kernel-6.1-x86_64"]
  }
}
