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

output "ssm_martini_build_image_name" {
  value       = aws_ssm_parameter.martini_build_image.name
  description = "The name of the SSM parameter for Martini build images"
}

output "ecr_repository_arn" {
  value       = aws_ecr_repository.martini_repository.arn
  description = "The ARN of the ECR repository for Martini"
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.martini_repository.repository_url
  description = "Full ECR URI for Docker image operations"
}
