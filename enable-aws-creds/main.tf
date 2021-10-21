variable "aws_access_key" {}
variable "aws_secret_key" {}



resource "vault_aws_secret_backend" "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  path       = "aws-dynamic-creds"

  default_lease_ttl_seconds = "120"
  max_lease_ttl_seconds     = "240"
}

resource "vault_aws_secret_backend_role" "PowerUser" {
  backend         = vault_aws_secret_backend.aws.path
  name            = "aws-dynamic-creds-role"
  credential_type = "iam_user"

  policy_document = <<EOF
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "NotAction": [
                  "iam:*",
                  "organizations:*",
                  "account:*"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "iam:CreateServiceLinkedRole",
                  "iam:DeleteServiceLinkedRole",
                  "iam:ListRoles",
                  "iam:GetUser",
                  "organizations:DescribeOrganization",
                  "account:ListRegions"
              ],
              "Resource": "*"
          }
      ]
  }
EOF
}

output "backend" {
  value = vault_aws_secret_backend.aws.path
}

output "role" {
  value = vault_aws_secret_backend_role.PowerUser.name
}
