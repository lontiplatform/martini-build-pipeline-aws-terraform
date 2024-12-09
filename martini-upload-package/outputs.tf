output "codebuild_project_name" {
  value       = aws_codebuild_project.martini_project.name
  description = "The name of the AWS CodeBuild project"
}

output "codepipeline_pipeline_name" {
  value       = aws_codepipeline.martini_pipeline.name
  description = "The name of the AWS CodePipeline project"
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.codebuild_artifacts.bucket
  description = "The name of the S3 bucket used for CodeBuild artifacts"
}

output "codebuild_role_arn" {
  value       = aws_iam_role.codebuild_role.arn
  description = "The ARN of the IAM role assigned to AWS CodeBuild"
}

output "codepipeline_role_arn" {
  value       = aws_iam_role.codepipeline_role.arn
  description = "The ARN of the IAM role assigned to AWS CodePipeline"
}

output "ssm_martini_upload_package_name" {
  value       = aws_ssm_parameter.martini_upload_package.name
  description = "The name of the SSM parameter for Martini build images"
}

output "cloudwatch_log_group_name" {
  value       = aws_cloudwatch_log_group.martini_project_log_group.name
  description = "The name of the CloudWatch Log Group"
}

output "cloudwatch_log_stream_name" {
  value       = aws_cloudwatch_log_stream.martini_project_log_stream.name
  description = "The name of the CloudWatch Log Stream"
}
