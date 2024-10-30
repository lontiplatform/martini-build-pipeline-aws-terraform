output "codebuild_project_name" {
  value = aws_codebuild_project.codebuild_name.name
}

output "codepipeline_project_name" {
  value = aws_codepipeline.codepipeline_name.name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.codebuild_artifacts.bucket
}

output "codebuild_role_arn" {
  value = aws_iam_role.codebuild_role.arn
}

output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline_role.arn
}
