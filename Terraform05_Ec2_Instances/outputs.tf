
output "ssit_http_server_sg_server_vpc_id_details" {
  value = aws_security_group.ssit_http_server_sg.vpc_id
}

# output "ssit_http_server_sg_server_ingress_details" {
#   value = aws_security_group.ssit_http_server_sg.ingress
# }

# output "ssit_http_server_sg_server_egress_details" {
#   value = aws_security_group.ssit_http_server_sg.egress
# }

output "ssit_ec2_instance_id_details" {
  value = aws_instance.ssit_ec2_instance.id
}

output "ssit_public_dns_details" {
  value = aws_instance.ssit_ec2_instance.public_dns
}

output "ssit_aws_ami_id_details" {
  value = data.aws_ami.ssit_aws_ami.id
}

