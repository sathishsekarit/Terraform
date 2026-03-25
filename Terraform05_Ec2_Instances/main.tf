# ap-south-2
# AMI - ami-022062aacfecac5bd (Amazon Linux 2023 kernel-6.1 AMI)
# Instance type  - t3.micro
# VPC - vpc-0da02b61d787cd061

provider "aws" {
  region = "ap-south-2"
}

# By default the vpc will be created, terraform cannot create, it will simply connect it
# Even if we destroy it, terraform cannot destroy simply remove connection.
resource "aws_default_vpc" "ssit_default_vpc" {
  tags = {
    Name = "ssit_default_vpc"
  }
}

# To create a instance we need to create a security group
# This security group will communicate on port 80 and 22 for protocol TCP
# The CIDR block is used to mention the range of ip address, to allow everywhere we can mention CIDR ["0.0.0.0/0"]   

# Protocol "-1": Using -1 in the egress block allows all protocols and ports.
# Tags: Added a Name tag to help identify the resource in the AWS Management Console.

# Separate Rule Resources: For larger projects, consider using the aws_security_group_rule resource. 
# This makes your code more modular and avoids the "merged rules" issue that can happen with inline blocks.

resource "aws_security_group" "ssit_http_server_sg" {

  name        = "ssit_http_server_sg"
  vpc_id      = aws_default_vpc.ssit_default_vpc.id
  description = "Allow HTTP and SSH inbound traffic"

  # Inbound rule for HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound rule for SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssit_http_server_sg"
  }

}

resource "aws_instance" "ssit_ec2_instance" {

  ami                    = data.aws_ami.ssit_aws_ami.id
  key_name               = "ssit_ec2_keyPair"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.ssit_http_server_sg.id]
  subnet_id              = data.aws_subnets.ssit_default_subnets.ids[0]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",                                                                                # install httpd
      "sudo service httpd start",                                                                                 # start httpd
      "echo Welcome to sathishsekarit aws ec2 instance at ${self.public_dns} | sudo tee /var/www/html/index.html" # copy to a file
    ]
  }
}
