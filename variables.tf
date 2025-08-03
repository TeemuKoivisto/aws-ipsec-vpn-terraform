variable "region" {
  type = string
}
variable "ssh_key_name" {
  type = string
}
variable "whitelisted_ips" {
  type = list(string)
}
variable "client_public_key" {
  type = string
}