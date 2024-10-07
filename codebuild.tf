resource "aws_codebuild_project" "example" {
  name        = local.project_name_codebuild  # CodeBuild project name
  description = "CodeBuild project"  # Description of the CodeBuild project

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"  # Compute resources
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"  # Build environment image
    type                        = "LINUX_CONTAINER"  # Environment type
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false  # Disable privileged mode

    environment_variable {
      name  = "ENV"  # Environment variable
      value = "production"
    }
  }

  source {
    type        = "GITHUB"  # Source repository type
    location    = "https://github.com/${var.repository_name}"  # GitHub repo URL
    buildspec   = var.buildspec_file  # Build specification file
    git_clone_depth = 1
  }

  artifacts {
    type                = "S3"  # Store artifacts in S3
    location            = aws_s3_bucket.codebuild_artifacts.bucket  # S3 bucket for artifacts
    packaging           = "NONE"
    encryption_disabled = false  # Ensure S3 encryption is enabled
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.codebuild_log_group.name  # Log group for CodeBuild
      stream_name = "${local.project_name_codebuild}-log"  # Log stream name
    }
  }

  service_role = aws_iam_role.codebuild_service_role.arn  # Service role for CodeBuild

  tags = var.tags  # Apply tags
}
