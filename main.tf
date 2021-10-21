
module "ENABLE-APPROLE" {
  source = "./enable-approle"
}

module "GET-TOKEN-VIA-APPROLE" {
  depends_on = [module.ENABLE-APPROLE]
  source = "./get-token-via-approle"
  role_id = module.ENABLE-APPROLE.role_id
}

module "ENABLE-AWS-CREDS" {
  depends_on = [module.GET-TOKEN-VIA-APPROLE]
  source = "./enable-aws-creds"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
}


module "GET-AWS-CREDS" {
  depends_on = [module.ENABLE-AWS-CREDS]
  source = "./get-aws-creds"
  backend = module.ENABLE-AWS-CREDS.backend
  role = module.ENABLE-AWS-CREDS.role
}



output "token-info" {
  value = module.GET-TOKEN-VIA-APPROLE.token-info
}

output "AWS-info" {
  value = module.GET-AWS-CREDS.aws_creds
}
