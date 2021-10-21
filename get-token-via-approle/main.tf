variable role_id {}


resource "vault_approle_auth_backend_role_secret_id" "id" {
  role_name = "radkowski"
}

resource "vault_approle_auth_backend_login" "login" {
  role_id   = var.role_id
  secret_id = vault_approle_auth_backend_role_secret_id.id.secret_id
}


output "token-info" {
  value = vault_approle_auth_backend_login.login
}
