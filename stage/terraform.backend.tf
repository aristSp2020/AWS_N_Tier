#terraform.backend: configuration cannot contain interpolations
terraform {
  required_version = ">= 0.11.10"

  backend "s3" {
    #encrypt = true
    bucket  = "mvc-sap-dev-terraform-state"
    key     = "meta/terraform_meta.tfstate"
    region  = "eu-west-1"
  }
}
