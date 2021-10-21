variable "backend" {}
variable "role" {}


data "vault_aws_access_credentials" "creds" {
  backend = var.backend
  role    = var.role
}


output "aws_creds" {
  value = data.vault_aws_access_credentials.creds
}
