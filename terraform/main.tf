terraform {
  backend "s3" {
    bucket         = "x-failures-to-1000-users-terraform-state-bucket-723849723"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    use_lockfile   = true
  }
}
