resource "aws_codebuild_project" "codebuild_name" {
  name        = "${var.environment}-${var.pipeline_name}-codebuild"  
  description = "CodeBuild project for Martini"

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false
  }

  source {
    type        = "GITHUB"
    location    = "https://github.com/${var.repository_name}"
    buildspec   = var.buildspec_file
    git_clone_depth = 1
  }

  artifacts {
    type                = "S3"
    location            = aws_s3_bucket.codebuild_artifacts.bucket
    packaging           = "NONE"
    encryption_disabled = false
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.codebuild_log_group.name
      stream_name = "${var.environment}-${var.pipeline_name}-codebuild-log"
    }
  }

  service_role = aws_iam_role.codebuild_role.arn

  tags = var.tags
}
