region              = "$ACTUAL_VALUE"  # AWS region for deployment
bucket_name         = "$ACTUAL_VALUE"  # S3 bucket name for artifacts
project_name        = "$ACTUAL_VALUE"  # CodeBuild project name
role_name           = "$ACTUAL_VALUE"  # IAM role for CodeBuild
pipeline_name       = "$ACTUAL_VALUE"  # CodePipeline project name
pipeline_role_name  = "$ACTUAL_VALUE"  # IAM role for CodePipeline
connection_arn      = "$ACTUAL_VALUE"  # CodeStar Connections GitHub connection ARN
repository_name     = "$ACTUAL_VALUE"  # Full GitHub repository name (e.g., "username/repo")
branch_name         = "$ACTUAL_VALUE"  # GitHub branch (e.g., "main")
buildspec_file      = "$ACTUAL_VALUE"  # Buildspec file for CodeBuild (e.g., "martini-build-image.yaml" or or "martini-upload-package.yaml")

tags = {
  Environment       = "$ACTUAL_VALUE"  # Deployment environment (e.g., Production)
  Project           = "$ACTUAL_VALUE"  # Project name
  Owner             = "$ACTUAL_VALUE"  # Resource owner
}
