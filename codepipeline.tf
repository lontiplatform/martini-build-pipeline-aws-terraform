resource "aws_codepipeline" "example" {
  name     = local.project_name_codepipeline  # CodePipeline project name
  role_arn = aws_iam_role.codepipeline_service_role.arn  # IAM role for CodePipeline

  artifact_store {
    type     = "S3"  # Artifact store type
    location = aws_s3_bucket.codebuild_artifacts.bucket  # S3 bucket for artifacts
  }

  stage {
    name = "Source"

    action {
      name             = "SourceAction"  # Source stage action name
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"  # GitHub connection
      version          = "1"
      configuration = {
        ConnectionArn   = var.connection_arn  # GitHub connection ARN
        FullRepositoryId = var.repository_name  # Full GitHub repository ID
        BranchName      = var.branch_name  # Branch to track
      }
      output_artifacts = ["source_output"]
    }
  }

  stage {
    name = "Build"

    action {
      name             = "BuildAction"  # Build stage action name
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"  # Build provider
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = aws_codebuild_project.example.name  # CodeBuild project name
      }
    }
  }

  tags = var.tags  # Apply tags
}
