module "vpn_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ipsec-vpn-sg"
  description = "VPN SG only accessible by whitelisted IPs"
  # vpc_id      = module.vpc.vpc_id

  # ingress_rules = ["https-443-tcp", "http-80-tcp", "ssh-tcp", "all-icmp"]
  # ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["all-all"]
}

resource "aws_security_group_rule" "vpn_ingress" {
  description = "PostgreSQL access for VPC, API and local machine"
  type        = "ingress"
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = flatten([
    [for ip in var.whitelisted_ips : "${ip}/32"],
  ])
  security_group_id = module.vpn_sg.security_group_id
}

resource "aws_key_pair" "ec2_ssh_key" {
  key_name   = var.ssh_key_name
  public_key = file("~/.ssh/${var.ssh_key_name}.pub")
}
