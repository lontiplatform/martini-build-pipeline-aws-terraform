resource "aws_cloudwatch_log_group" "martini_project_log_group" {
  name              = "/aws/codebuild/${local.name_prefix}-codebuild"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}

resource "aws_cloudwatch_log_group" "codepipeline_log_group" {
  name              = "/aws/codepipeline/${local.name_prefix}-codepipeline"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}
