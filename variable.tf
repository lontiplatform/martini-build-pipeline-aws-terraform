variable "region" {
  description = "AWS region for deployment"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name for storing artifacts"
  type        = string
}

variable "project_name" {
  description = "CodeBuild project name"
  type        = string
}

variable "role_name" {
  description = "IAM role name for CodeBuild"
  type        = string
}

variable "pipeline_name" {
  description = "CodePipeline project name"
  type        = string
}

variable "pipeline_role_name" {
  description = "IAM role name for CodePipeline"
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

variable "buildspec_file" {
  description = "Buildspec file for CodeBuild (e.g., 'martini-build-image.yaml' or 'martini-upload-package.yaml')"
  type        = string

  validation {
    condition     = contains(["martini-build-image.yaml", "martini-upload-package.yaml"], var.buildspec_file)
    error_message = "buildspec_file must be either 'martini-build-image.yaml' or 'martini-upload-package.yaml'."
  }
}