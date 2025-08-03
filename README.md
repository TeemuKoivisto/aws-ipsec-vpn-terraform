# [AWS wireguard VPN terraform stack](https://github.com/TeemuKoivisto/aws-wireguard-vpn-terraform)

To run them, you need:

- [Terraform](https://www.terraform.io/) (`brew install terraform`)
- Wireguard (`brew install wireguard-tools`)
- AWS credentials

1. Create Wireguard conf at: `/opt/homebrew/etc/wireguard`
2. Update its conf to `wg0.conf`, replacing only PrivateKey
3. Create S3 bucket in a region of your desire
4. Copy env `cp .env-example .env`
5. In `.env` change:

- AWS credentials
- region (if not eu-central-1)
- ssh key name
- your ip
- client publickey (from `/opt/homebrew/etc/wireguard`)

6. Add the S3 bucket to `backend.conf`
7. Initialize Terraform: `./ex.sh tf init -backend-config=backend.conf`
8. Apply the stacks: `./ex.sh tf apply`
9. Copy the publickey & ip to your wg0.conf: `./ex.sh sync`
10. NOTE: If sync fails to copy the file, you might have to ssh manually: `./ex.sh ssh <ip>`
11. Start Wireguard: `./ex.sh wup`
12. Stop Wireguard: `./ex.sh wdown`
13. When you no longer need the VPN, run: `./ex.sh tf destroy`

## References

https://blog.scottlowe.org/2021/06/28/using-wireguard-on-mac-via-cli/

https://blog.scottlowe.org/2021/02/22/setting-up-wireguard-for-aws-vpc-access/
