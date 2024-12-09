variable "environment" {
  description = "Environment name (e.g., 'dev', 'prod')"
  type        = string
}

variable "pipeline_name" {
  description = "CodePipeline project name"
  type        = string
}

variable "connection_arn" {
  description = "CodeStar connection ARN for GitHub"
  type        = string
}

variable "repository_name" {
  description = "Full GitHub repository name (e.g., 'username/repo')"
  type        = string
}

variable "branch_name" {
  description = "Branch name for CodePipeline"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "log_retention_days" {
  description = "Retention period for CloudWatch logs (in days)"
  type        = number
}

variable "buildspec_file" {
  description = "Buildspec file for CodeBuild ('martini-upload-package.yaml')"
  type        = string
}

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
}

variable "parameter_name" {
  description = "Name of the SSM Parameter to store configuration values"
  type        = string
}

variable "base_url" {
  description = "The URL of the remote Martini runtime server."
  type        = string
}

variable "martini_user_name" {
  description = "The username used to generate the OAuth token from the remote Martini runtime server."
  type        = string
}

variable "martini_user_password" {
  description = "The password used to generate the OAuth token from the remote Martini runtime server."
  type        = string
}
