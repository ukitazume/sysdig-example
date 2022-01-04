terraform {
  required_version = "1.1.2"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ukitazume"

    workspaces {
      name = "sysdig-example-aws-connector"
    }
  }
}

variable "sysdig_secure_endpoint" {
  type    = string
  default = "https://secure.sysdig.com"
}

variable "sysdig_secure_api_token" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

provider "aws" {
  region = var.aws_region
}


module "secure-for-cloud_example_single-account" {
  source = "sysdiglabs/secure-for-cloud/aws//examples/single-account"


  sysdig_secure_endpoint  = var.sysdig_secure_endpoint
  sysdig_secure_api_token = var.sysdig_secure_api_token

  name              = "sfc"
  deploy_benchmark  = true
  benchmark_regions = [var.aws_region]
}
