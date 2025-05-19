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

variable "martini_access_token" {
  description = "Long-lived OAuth token used to authenticate with the remote Martini runtime server."
  type        = string
}

variable "package_name_pattern" {
  type        = string
  default     = ".*"
  description = "Regex pattern to match packages to be uploaded"
}

variable "package_dir" {
  type        = string
  default     = "packages"
  description = "Directory containing the packages to be uploaded"
}

variable "async_upload" {
  type        = string
  default     = "false"
  description = "Set to true to treat HTTP 504 as successful upload"
}

variable "success_check_timeout" {
  type        = number
  default     = 6
  description = "Polling attempts for package status check"
}

variable "success_check_delay" {
  type        = number
  default     = 30
  description = "Delay between polling attempts (seconds)"
}

variable "success_check_package_name" {
  type        = string
  default     = ""
  description = "Specific package name to poll for success status"
}

