resource "aws_codepipeline" "martini_pipeline" {
  name     = "${var.environment}-${var.pipeline_name}-codepipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codebuild_artifacts.bucket
  }

  stage {
    name = "Source"

    action {
      name     = "SourceAction"
      category = "Source"
      owner    = "AWS"
      provider = "CodeStarSourceConnection"
      version  = "1"
      configuration = {
        ConnectionArn    = var.connection_arn
        FullRepositoryId = var.repository_name
        BranchName       = var.branch_name
      }
      output_artifacts = ["source_output"]
    }
  }

  stage {
    name = "Build"

    action {
      name             = "BuildAction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = aws_codebuild_project.martini_project.name
      }
    }
  }

  tags = var.tags
}
