
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

For a complete list of inputs and their descriptions, see the [Input Reference](#input-reference)

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

- **Buildspec and Script**: This module expects the `martini-build-image.yaml` buildspec and `Dockerfile` to exist in the source GitHub repository.
- **Parameter Management**: The `ssm.tf` file defines a secure parameter in AWS SSM Parameter Store, which provides dynamic runtime configuration to CodeBuild jobs.
- **Security**: All secrets are stored in AWS Systems Manager Parameter Store as `SecureString` values.
- **Monitoring & Debugging**: Use CloudWatch logs to troubleshoot issues in the build and pipeline stages. Log retention is configurable via `log_retention_days`.
- **Automation**: The pipeline automatically triggers on commits to the specified Git branch.


## Input Reference

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS Account ID | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region for deployment | `string` | n/a | yes |
| <a name="input_branch_name"></a> [branch\_name](#input\_branch\_name) | Branch name for CodePipeline | `string` | n/a | yes |
| <a name="input_buildspec_file"></a> [buildspec\_file](#input\_buildspec\_file) | Buildspec file for CodeBuild (e.g., 'martini-build-image.yaml') | `string` | n/a | yes |
| <a name="input_connection_arn"></a> [connection\_arn](#input\_connection\_arn) | CodeStar connection ARN for GitHub | `string` | n/a | yes |
| <a name="input_ecr_repo_name"></a> [ecr\_repo\_name](#input\_ecr\_repo\_name) | ECR repository name for Martini builds | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (e.g., 'dev', 'prod') | `string` | `"dev"` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | Retention period for CloudWatch logs (in days) | `number` | n/a | yes |
| <a name="input_martini_version"></a> [martini\_version](#input\_martini\_version) | Version of Martini to be used in the build | `string` | n/a | yes |
| <a name="input_parameter_name"></a> [parameter\_name](#input\_parameter\_name) | Name of the SSM Parameter to store configuration values | `string` | `"martini-build-image"` | no |
| <a name="input_pipeline_name"></a> [pipeline\_name](#input\_pipeline\_name) | CodePipeline project name | `string` | n/a | yes |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | Full GitHub repository name (e.g., 'username/repo') | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | n/a | yes |
