module "vpc" {
  source          = "./vpc"
  region          = var.region
  ssh_key_name    = var.ssh_key_name
  whitelisted_ips = var.whitelisted_ips
}
