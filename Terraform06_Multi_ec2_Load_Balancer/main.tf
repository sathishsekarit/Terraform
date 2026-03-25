
provider "aws" {
  region = "ap-south-2"
}

resource "aws_default_vpc" "ssit_default_vpc" {
  tags = {
    Name = "ssit_default_vpc"
  }
}

resource "aws_security_group" "ssit_lb_sg" {

  name        = "ssit_lb_sg"
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
    Name = "ssit_lb_sg"
  }

}


resource "aws_elb" "ssit_load_balancer" {
  name            = "ssit-load-balancer"
  subnets         = data.aws_subnets.ssit_default_subnets.ids
  security_groups = toset([aws_security_group.ssit_lb_sg.id])
  instances       = values(aws_instance.ssit_ec2_instances).*.id

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

resource "aws_instance" "ssit_ec2_instances" {

  ami                    = data.aws_ami.ssit_aws_ami.id
  key_name               = "ssit_ec2_keyPair"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.ssit_lb_sg.id]

  for_each  = toset(data.aws_subnets.ssit_default_subnets.ids)
  subnet_id = each.value

  tags = {
    Name = "ssit_ec2_instance_${each.value}"
  }

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
