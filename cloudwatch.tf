resource "aws_cloudwatch_log_group" "codebuild_log_group" {
  name              = "/aws/codebuild/${var.environment}-${var.pipeline_name}-codebuild"
  retention_in_days = var.log_retention_days  

  tags = var.tags  
}

resource "aws_cloudwatch_log_group" "codepipeline_log_group" {
  name              = "/aws/codepipeline/${var.environment}-${var.pipeline_name}-codepipeline"
  retention_in_days = var.log_retention_days  

  tags = var.tags 
}
