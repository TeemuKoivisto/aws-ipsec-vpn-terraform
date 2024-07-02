# [AWS ipsec VPN terraform stack](https://github.com/TeemuKoivisto/aws-ipsec-vpn-terraform)

To run them, you need [Terraform](https://www.terraform.io/) (`brew install terraform`) and AWS credentials.

1. Create S3 bucket in a region of your desire
2. Add your AWS credentials (VPC & EC2 access), region, ssh key and ip to `.env`: `cp .env-example .env`
3. Add the S3 bucket to `backend.conf`
4. Initialize Terraform: `./ex.sh tf init -backend-config=backend.conf`
5. Apply the stacks: `./ex.sh tf apply`
6. Get the EC2 IP from the "Outputs": `ec2_ip = "1.1.1.1"`
7. SSH into it: `./ex.sh ssh <ip>` or `ssh -o "IdentitiesOnly=yes" -i ~/.ssh/<your key> ubuntu@<ip>`
8. Install ipsec-vpn: `wget https://get.vpnsetup.net -O vpn.sh && sudo sh vpn.sh`
9. Setup the VPN connection https://github.com/hwdsl2/setup-ipsec-vpn/blob/master/docs/clients.md
10. When you no longer need the VPN, run: `./ex.sh tf destroy`
