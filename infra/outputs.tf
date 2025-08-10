output "ec2_ip" {
  value = module.ec2_instance.public_ip
}
output "cidr_blocks" {
  value = jsonencode(aws_security_group_rule.vpn_ingress.cidr_blocks)
}