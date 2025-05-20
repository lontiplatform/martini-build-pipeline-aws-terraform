
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

Update the `terraform.tfvars` file or override variables via CLI to configure:

- `environment`: Deployment environment name (e.g., `dev`, `prod`).
- `pipeline_name`: CodePipeline project name.
- `repository_name`: GitHub repository (e.g., `lontiplatform/martini-build-pipeline-aws`).
- `branch_name`: Git branch name to trigger builds.
- `connection_arn`: CodeStar Connection ARN (manually generated in AWS console).
- `parameter_name`: Name of the SSM parameter holding runtime config.
- `buildspec_file`: Path to the buildspec file used in CodeBuild (e.g., `martini-upload-package.yaml`).
- `aws_region`: AWS region for deployment.
- `aws_account_id`: Your AWS Account ID.
- `tags`: Common tags to assign to all resources.
- `log_retention_days`: CloudWatch log retention in days.
- `base_url`: Base URL of the Martini instance.
- `martini_access_token`: Authentication token for the target Martini runtime.
- `package_name_pattern`: Regex pattern to match package directories to upload.
- `package_dir`: Directory where packages are located (default: `packages`).
- `async_upload`: Whether to support HTTP 504 async responses.
- `success_check_timeout`: Polling retry limit for status check.
- `success_check_delay`: Delay between polling attempts.
- `success_check_package_name`: Optional: Poll only this package name.

### Deploy the Module

```bash
terraform init
terraform plan
terraform apply
```

## Additional Notes

- **Parameter Management**: The `ssm.tf` file defines a secure parameter in SSM. This parameter feeds dynamic runtime values into CodeBuild jobs.
- **Buildspec and Script**: This module expects the `martini-upload-package.yaml` buildspec and `upload_packages.sh` script to exist in the GitHub source.
- **Security**: All secrets are stored in AWS Systems Manager Parameter Store as SecureStrings.
- **Logs**: Check CloudWatch for build/pipeline logs. Retention period is configurable.
- **Triggers**: Automatically runs on commits to the specified branch.

## References

- [Martini CI/CD Documentation](https://developer.lonti.com/docs/martini/cicd/automated-deployment/aws-codepipeline)
- [Terraform SSM Parameter Store Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter)
- [AWS CodePipeline Docs](https://docs.aws.amazon.com/codepipeline)
- [Martini Build Pipeline Repository](https://github.com/lontiplatform/martini-build-pipeline-aws)
