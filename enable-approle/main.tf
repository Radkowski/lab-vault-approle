
resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_policy" "approle-policy" {
  name = "approle-policy"

  policy = <<EOT
path "kv/*" {
  capabilities = ["list", "read"]
}
EOT
}

resource "vault_approle_auth_backend_role" "radkowski" {
  backend        = vault_auth_backend.approle.path
  role_name      = "radkowski"
  token_policies = ["default", vault_policy.approle-policy.name]

  }

data "vault_approle_auth_backend_role_id" "role" {
  role_name = "radkowski"
}

output "role_id" {
  value = vault_approle_auth_backend_role.radkowski.role_id
}
