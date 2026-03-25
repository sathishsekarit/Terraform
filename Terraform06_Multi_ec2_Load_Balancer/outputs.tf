
output "ssit_http_server_sg_server_vpc_id_details" {
  value = aws_security_group.ssit_lb_sg.vpc_id
}

output "ssit_ec2_instance_id_details" {
  value = values(aws_instance.ssit_ec2_instances).*.id
}

output "ssit_public_dns_details" {
  value = values(aws_instance.ssit_ec2_instances).*.public_dns
}

output "ssit_aws_ami_id_details" {
  value = data.aws_ami.ssit_aws_ami.id
}

output "ssit_aws_elb_dns_name" {
  value = aws_elb.ssit_load_balancer.dns_name
}
