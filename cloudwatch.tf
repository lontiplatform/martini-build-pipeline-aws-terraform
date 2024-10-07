resource "aws_cloudwatch_log_group" "codebuild_log_group" {
  name              = "/aws/codebuild/${local.project_name_codebuild}"
  retention_in_days = 90  # Log retention set to 90 days

  tags = var.tags  # Apply tags
}

resource "aws_cloudwatch_log_group" "codepipeline_log_group" {
  name              = "/aws/codepipeline/${local.project_name_codepipeline}"
  retention_in_days = 90  # Log retention set to 90 days

  tags = var.tags  # Apply tags
}
