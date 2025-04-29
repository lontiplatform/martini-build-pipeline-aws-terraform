# Martini Package Upload with AWS CodePipeline

This Terraform module configures an AWS CodePipeline for uploading Martini packages to a specified Martini instance. The pipeline ensures controlled and automated deployments by integrating package management and secure configuration handling into a streamlined CI/CD workflow.

## Overview

This Terraform template automates the process of zipping and uploading Martini packages to a Martini instance.

## Repository Structure

The repository includes the following Terraform files:

- `cloudwatch.tf`: Sets up CloudWatch log groups for build and pipeline monitoring.
- `codebuild.tf`: Configures CodeBuild to execute the upload process.
- `codepipeline.tf`: Defines CodePipeline for managing CI/CD stages, linked to GitHub.
- `iam.tf`: Manages IAM roles and policies for CodeBuild, CodePipeline, and other AWS services.
- `main.tf`: Sets the AWS provider and dynamic naming conventions.
- `outputs.tf`: Exports key resource ARNs (e.g., CodeBuild project, CodePipeline).
- `s3.tf`: Configures an S3 bucket for temporary artifact storage.
- `ssm.tf`: Defines parameters for secure storage of sensitive configuration values in AWS Systems Manager Parameter Store.
- `variables.tf`: Declares variables with validations and detailed descriptions.

## Usage

### Clone the Repository

```bash
git clone https://github.com/torocloud/martini-aws-codepipeline-terraform-module.git
cd martini-aws-codepipeline-terraform-module/martini-upload-package
```

### Configure Variable Inputs

Update the `variables.tf` file or pass values via `terraform.tfvars` to customize the following:

- **`environment`**: Environment name (e.g., 'dev', 'prod').
- **`pipeline_name`**: CodePipeline project name.
- **`repository_name`**: Full GitHub repository name (e.g., 'username/repo').
- **`branch_name`**: Branch name for CodePipeline.
- **`tags`**: Tags to apply to resources.
- **`log_retention_days`**: Retention period for CloudWatch logs (in days).
- **`buildspec_file`**: Buildspec file for CodeBuild ('martini-upload-package.yaml').
- **`base_url`**: Base URL of the Martini instance.
- **`martini_user_name`**: Username for authentication with the Martini instance.
- **`martini_user_password`**: Password for authentication with the Martini instance.
- **`aws_region`**: AWS region for deployment.
- **`aws_account_id`**: AWS Account ID.
- **`parameter_name`**: Name of the SSM Parameter to store configuration values.
- **`allowed_packages`**: Single or comma-separated list of allowed packages.
- **`connection_arn`**: CodeStar connection ARN for GitHub.

**Note**: CodeStar Connections - The connection must be created manually in the AWS Management Console due to the required authentication flow with the external platform. Once created, it generates a Connection ARN that can be referenced in automation tools like Terraform.

### Deploy the Module

Run the following Terraform commands:

1. Initialize the Terraform configuration:
   ```bash
   terraform init
   ```

2. Preview the resources to be created:
   ```bash
   terraform plan
   ```

3. Apply the configuration to deploy resources:
   ```bash
   terraform apply
   ```

## Additional Notes

- **Debugging**: Use CloudWatch logs to troubleshoot build and pipeline errors.
- **SSM Parameters**: Securely store sensitive values, such as Martini user credentials and allowed packages, using AWS Systems Manager Parameter Store. Make sure to set the actual `parameter_name` in the buildspec file before running a build.
- **Retention Policies**: Log groups created in CloudWatch have a customizable retention period defined in `variable.tf`.