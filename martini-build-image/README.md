
# Martini Build Image with AWS CodePipeline

This Terraform template configures an AWS CodePipeline for building Docker images that integrate the Martini Server Runtime and associated packages. The pipeline ensures controlled and consistent deployments by bundling specified Martini runtime versions and packages into a unified Docker image.

## Overview

This Terraform template automates the process of building a Docker image containing s specific version of Martini Server Runtime and Martini Packages.

## Repository Structure

The repository includes the following Terraform files:

- `cloudwatch.tf`: Sets up CloudWatch log groups for build and pipeline monitoring.
- `codebuild.tf`: Configures CodeBuild to compile and test Martini integrations.
- `codepipeline.tf`: Defines CodePipeline for managing CI/CD stages, linked to GitHub.
- `ecr.tf`: Manages the Elastic Container Registry (ECR) for storing Martini Docker images.
- `iam.tf`: Manages IAM roles and policies for CodeBuild, CodePipeline, and other AWS services.
- `main.tf`: Sets the AWS provider and dynamic naming conventions.
- `outputs.tf`: Exports key resource ARNs (e.g., CodeBuild project, CodePipeline).
- `s3.tf`: Configures an S3 bucket for build artifacts with KMS encryption.
- `ssm.tf`: Defines parameters for secure storage of sensitive configuration values in AWS Systems Manager Parameter Store.
- `variables.tf`: Declares variables with validations and detailed descriptions.

## Usage

### Clone the Repository

```bash
git clone https://github.com/torocloud/martini-aws-codepipeline-terraform-module.git
cd martini-aws-codepipeline-terraform-module/martini-build-image
```

### Configure Variable Inputs

Update the `variables.tf` file or pass values via `terraform.tfvars` to customize the following:

- **`environment`**: Environment name (e.g., 'dev', 'prod').
- **`pipeline_name`**: CodePipeline project name.
- **`repository_name`**: Full GitHub repository name (e.g., 'username/repo').
- **`branch_name`**: Branch name for CodePipeline.
- **`tags`**: Tags to apply to resources.
- **`log_retention_days`**: Retention period for CloudWatch logs (in days).
- **`buildspec_file`**: Buildspec file for CodeBuild ('martini-build-image.yaml').
- **`martini_version`**: Martini runtime version to be used.
- **`aws_region`**: AWS region for deployment.
- **`aws_account_id`**: AWS Account ID.
- **`ecr_repo_name`**: ECR repository name for Martini builds.
- **`parameter_name`**: Name of the SSM Parameter to store configuration values.
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
- **SSM Parameters**: Securely store sensitive values, such as Martini user credentials, using AWS Systems Manager Parameter Store. Make sure to set the actual `parameter_name` in the buildspec file before running a build.
- **Retention Policies**: Log groups created in CloudWatch have a customizable retention period defined in `variable.tf`.


