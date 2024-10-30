provider "aws" {
  region = var.region  # AWS region
}

data "aws_caller_identity" "current" {}

