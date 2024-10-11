variable "region" {
  description = "AWS region for deployment"
  type        = string
}

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

variable "parameter_name" {
  description = "The name of the SSM Parameter that needs to be retrieved"
  type        = string
}

variable "buildspec_file" {
  description = "Buildspec file for CodeBuild (e.g., 'martini-build-image.yaml' or 'martini-upload-package.yaml')"
  type        = string

  validation {
    condition     = contains(["martini-build-image.yaml", "martini-upload-package.yaml"], var.buildspec_file)
    error_message = "buildspec_file must be either 'martini-build-image.yaml' or 'martini-upload-package.yaml'."
  }
}

