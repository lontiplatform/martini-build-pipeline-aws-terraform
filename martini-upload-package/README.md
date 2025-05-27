# Martini Package Upload with AWS CodePipeline

This Terraform module configures an AWS CodePipeline for uploading Martini packages to a specified Martini instance. The pipeline ensures controlled and automated deployments by integrating package management and secure configuration handling into a streamlined CI/CD workflow.

## Overview

This module automates the process of zipping and uploading Martini packages to a Martini instance using AWS CodeBuild and CodePipeline. It supports dynamic filtering, asynchronous polling, and runtime parameter injection from SSM Parameter Store.

## Repository Structure

The module directory includes the following Terraform configuration files:

- `cloudwatch.tf`: Sets up CloudWatch log groups for build and pipeline monitoring.
- `codebuild.tf`: Configures CodeBuild to execute the upload process using a buildspec.
- `codepipeline.tf`: Defines CodePipeline for managing CI/CD stages, linked to GitHub via CodeStar Connection.
- `iam.tf`: Manages IAM roles and policies for CodeBuild, CodePipeline, and other AWS services.
- `main.tf`: Sets the AWS provider and dynamic naming conventions.
- `outputs.tf`: Exports key resource ARNs (e.g., CodeBuild project, CodePipeline).
- `s3.tf`: Configures an S3 bucket for temporary artifact storage.
- `ssm.tf`: Defines a SecureString parameter to store Martini upload configuration in AWS Systems Manager Parameter Store.
- `variables.tf`: Declares required and optional variables with validations and default fallbacks.

## Usage

### Clone the Repository

```bash
git clone https://github.com/lontiplatform/martini-build-pipeline-aws-terraform.git
cd martini-build-pipeline-aws-terraform/martini-upload-package
```

### Configure Inputs

For a complete list of inputs and their descriptions, see the [Inputs Reference](#inputs-reference)

**Note**: CodeStar Connections - The connection must be created manually in the AWS Management Console due to the required authentication flow with the external platform. Once created, it generates a Connection ARN that can be referenced in automation tools like Terraform.

### Deploy the Module

```bash
terraform init
terraform plan
terraform apply
```

## Additional Notes

- **Buildspec and Script**: This module expects the `martini-upload-package.yaml` buildspec and `upload_packages.sh` script to exist in the source GitHub repository.
- **Parameter Management**: The `ssm.tf` file defines a secure parameter in AWS SSM Parameter Store, which provides dynamic runtime configuration to CodeBuild jobs.
- **Security**: Secrets like tokens and URLs are securely stored as `SecureString` values in Parameter Store.
- **Monitoring & Debugging**: CloudWatch logs are available for both build and pipeline stages. Use them to troubleshoot issues. Log retention is configurable via `log_retention_days`.
- **Automation**: Pipelines are automatically triggered by commits to the specified Git branch.

## Inputs Reference

| Name                         | Description                                                               | Type         | Default                  | Required |
|------------------------------|---------------------------------------------------------------------------|--------------|--------------------------|:--------:|
| async_upload                 | Set to true to treat HTTP 504 as successful upload                        | bool         | false                    | no       |
| base_url                     | The URL of the remote Martini runtime server                              | string       | n/a                      | yes      |
| branch_name                  | Branch name for CodePipeline                                              | string       | n/a                      | yes      |
| buildspec_file               | Buildspec file for CodeBuild (e.g., 'martini-upload-package.yaml')        | string       | n/a                      | yes      |
| connection_arn               | CodeStar connection ARN for GitHub                                        | string       | n/a                      | yes      |
| environment                  | Environment name (e.g., 'dev', 'prod')                                    | string       | "dev"                    | no       |
| log_retention_days           | Retention period for CloudWatch logs (in days)                            | number       | n/a                      | yes      |
| martini_access_token         | Long-lived OAuth token used to authenticate with the remote runtime       | string       | n/a                      | yes      |
| package_dir                  | Directory containing the packages to be uploaded                          | string       | "packages"               | no       |
| package_name_pattern         | Regex pattern to match packages to be uploaded                            | string       | ".*"                     | no       |
| parameter_name               | Name of the SSM Parameter to store configuration values                   | string       | "martini-upload-package" | no       |
| pipeline_name                | CodePipeline project name                                                 | string       | n/a                      | yes      |
| repository_name              | Full GitHub repository name (e.g., 'username/repo')                       | string       | n/a                      | yes      |
| success_check_delay          | Delay between polling attempts (seconds)                                  | number       | 30                       | no       |
| success_check_package_name   | Specific package name to poll for success status                          | string       | ""                       | no       |
| success_check_timeout        | Polling attempts for package status check                                 | number       | 6                        | no       |
| tags                         | Tags to apply to resources                                                | map(string)  | n/a                      | yes      |
