terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.22.1"
    }
  }
   backend "s3" {
    bucket    = "kardev-remote-state"
    key       = "roboshop-dev/eksCluster"
    region    = "us-east-1"
    use_lockfile = true
    encrypt= true
   }
}

provider "aws" {
  # Configuration options
}