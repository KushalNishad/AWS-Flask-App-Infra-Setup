terraform {
  backend "s3" {
    bucket        = "your-terraform-state-bucket"
    key           = "env/dev/terraform.tfstate"
    region        = "us-east-1"
    encrypt       = true
    use_lockfile  = true
  }
}