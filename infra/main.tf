module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project}-ec2"

  instance_type          = "t2.micro"
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [module.vpn_sg.security_group_id]
  # Ubuntu 22.04
  ami = "ami-04e601abe3e1a910f"

  monitoring = true

  tags = {
    Project = "${var.project}"
  }
}

module "vpn_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.project}-sg"
  description = "VPN SG"

  egress_rules = ["all-all"]
}

resource "aws_security_group_rule" "vpn_ingress" {
  description = "Restrict access to only whitelisted IPs"
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = -1
  cidr_blocks = flatten([
    [for ip in var.whitelisted_ips : "${ip}/32"],
  ])
  security_group_id = module.vpn_sg.security_group_id
}

resource "aws_key_pair" "ec2_ssh_key" {
  key_name   = var.ssh_key_name
  public_key = file("~/.ssh/${var.ssh_key_name}.pub")
}
