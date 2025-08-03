# [AWS wireguard VPN terraform stack](https://github.com/TeemuKoivisto/aws-ipsec-vpn-terraform)

To run them, you need [Terraform](https://www.terraform.io/) (`brew install terraform`), Wireguard (`brew install wireguard-tools`) and AWS credentials.

1. Create S3 bucket in a region of your desire
2. Add your AWS credentials (VPC & EC2 access), region, ssh key and ip to `.env`: `cp .env-example .env`
3. Add the S3 bucket to `backend.conf`
4. Initialize Terraform: `./ex.sh tf init -backend-config=backend.conf`
5. Apply the stacks: `./ex.sh tf apply`
6. Initialize local Wireguard(?)
7. Copy the publickey & ip to local wg0.conf: `./ex.sh sync`
8. NOTE: If sync fails to copy the file, you might have to ssh manually: `./ex.sh ssh <ip>`
9. Start Wireguard: `./ex.sh wup`
10. Stop Wireguard: `./ex.sh wdown`
11. When you no longer need the VPN, run: `./ex.sh tf destroy`

## References

https://blog.scottlowe.org/2021/06/28/using-wireguard-on-mac-via-cli/

https://blog.scottlowe.org/2021/02/22/setting-up-wireguard-for-aws-vpc-access/
