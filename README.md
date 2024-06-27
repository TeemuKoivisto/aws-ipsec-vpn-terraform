# AWS ipsec VPN terraform stack

To run them, you need [Terraform](https://www.terraform.io/) (`brew install terraform`) and AWS credentials.

1. Create S3 bucket in a region of your desire
2. Add your AWS credentials (VPC & EC2 access) and other stuff to `.env`: `cp .env-example .env`
3. Add the S3 bucket to `backend.conf`
4. Initialize Terraform: `./ex.sh tf init -backend-config=backend.conf`
5. Apply the stacks: `./ex.sh tf apply`
6. Get the EC2 IP from console
7. SSH into it: `ssh -o "IdentitiesOnly=yes" -i ~/.ssh/<your key> ubuntu@<ip>`
8. Install ipsec-vpn: `wget https://get.vpnsetup.net -O vpn.sh && sudo sh vpn.sh`
