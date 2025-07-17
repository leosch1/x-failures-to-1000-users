terraform {
  backend "local" {
    path = "localstack.tfstate"
  }
}

provider "aws" {
  region                      = "eu-central-1"
  access_key                  = "test"
  secret_key                  = "test"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    iam        = "http://localhost:4566"
    s3         = "http://localhost:4566"
    lambda     = "http://localhost:4566"
    apigateway = "http://localhost:4566"
    sts        = "http://localhost:4566"
    cloudwatch = "http://localhost:4566"
    logs       = "http://localhost:4566"
    route53    = "http://localhost:4566"
  }
}

module "backend" {
  source = "../../modules/backend"
  providers = {
    aws = aws
  }
}

output "api_url" {
  value = "http://localhost:4566/restapis/${module.backend.api_gateway_id}/${module.backend.api_gateway_stage}/_user_request_/"
}
