provider "aws" {
  region = var.aws_region # AWS region
}

data "aws_caller_identity" "current" {}
