provider "aws" {
  region = var.region  # AWS region
}

resource "time_static" "now" {}

locals {
  today = formatdate("YYYYMMDD", time_static.now.id)  # Current date for dynamic naming
  
  # Dynamic project and role names
  project_name_codebuild   = "${var.region}-${local.today}-${var.project_name}-codebuild"
  project_name_s3          = "${var.region}-${local.today}-${var.bucket_name}-s3-artifacts"
  project_name_codepipeline = "${var.region}-${local.today}-${var.pipeline_name}-codepipeline"
  role_name_codebuild      = "${var.region}-${local.today}-${var.project_name}-codebuild-role"
  role_name_codepipeline   = "${var.region}-${local.today}-${var.pipeline_name}-codepipeline-role"
}
