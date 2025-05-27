variable "environment" {
  description = "Environment name (e.g., 'dev', 'prod')"
  type        = string
  default     = "dev"
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
  description = "Buildspec file for CodeBuild (e.g., 'martini-build-image.yaml')"
  type        = string
}

variable "martini_version" {
  description = "Version of Martini to be used in the build. If not provided, it defaults to LATEST."
  type        = string
  default     = "latest"
}

variable "parameter_name" {
  description = "Name of the SSM Parameter to store configuration values"
  type        = string
  default     = "martini-build-image"
}
