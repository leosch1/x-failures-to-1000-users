terraform {
  backend "s3" {
    bucket       = "x-failures-to-1000-users-terraform-state-bucket-723849723"
    key          = "terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

module "x_failures_to_1000_users" {
  source = "../../resources"
  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}

# output "api_url" {
#   value = module.x_failures_to_1000_users.api_url
# }
