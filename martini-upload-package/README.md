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

## References
- [Martini CI/CD Documentation](https://developer.lonti.com/docs/martini/cicd/automated-deployment/aws-codepipeline)
- [Terraform SSM Parameter Store Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter)
- [AWS CodePipeline Docs](https://docs.aws.amazon.com/codepipeline)
- [Martini Build Pipeline Repository](https://github.com/lontiplatform/martini-build-pipeline-aws)

## Inputs Reference

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_async_upload"></a> [async\_upload](#input\_async\_upload) | Set to true to treat HTTP 504 as successful upload | `bool` | `"false"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region for deployment | `string` | n/a | yes |
| <a name="input_base_url"></a> [base\_url](#input\_base\_url) | The URL of the remote Martini runtime server. | `string` | n/a | yes |
| <a name="input_branch_name"></a> [branch\_name](#input\_branch\_name) | Branch name for CodePipeline | `string` | n/a | yes |
| <a name="input_buildspec_file"></a> [buildspec\_file](#input\_buildspec\_file) | Buildspec file for CodeBuild (e.g., 'martini-upload-package.yaml') | `string` | n/a | yes |
| <a name="input_connection_arn"></a> [connection\_arn](#input\_connection\_arn) | CodeStar connection ARN for GitHub | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (e.g., 'dev', 'prod') | `string` | `"dev"` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | Retention period for CloudWatch logs (in days) | `number` | n/a | yes |
| <a name="input_martini_access_token"></a> [martini\_access\_token](#input\_martini\_access\_token) | Long-lived OAuth token used to authenticate with the remote Martini runtime server. | `string` | n/a | yes |
| <a name="input_package_dir"></a> [package\_dir](#input\_package\_dir) | Directory containing the packages to be uploaded | `string` | `"packages"` | no |
| <a name="input_package_name_pattern"></a> [package\_name\_pattern](#input\_package\_name\_pattern) | Regex pattern to match packages to be uploaded | `string` | `".*"` | no |
| <a name="input_parameter_name"></a> [parameter\_name](#input\_parameter\_name) | Name of the SSM Parameter to store configuration values | `string` | `"martini-upload-package"` | no |
| <a name="input_pipeline_name"></a> [pipeline\_name](#input\_pipeline\_name) | CodePipeline project name | `string` | n/a | yes |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | Full GitHub repository name (e.g., 'username/repo') | `string` | n/a | yes |
| <a name="input_success_check_delay"></a> [success\_check\_delay](#input\_success\_check\_delay) | Delay between polling attempts (seconds) | `number` | `30` | no |
| <a name="input_success_check_package_name"></a> [success\_check\_package\_name](#input\_success\_check\_package\_name) | Specific package name to poll for success status | `string` | `""` | no |
| <a name="input_success_check_timeout"></a> [success\_check\_timeout](#input\_success\_check\_timeout) | Polling attempts for package status check | `number` | `6` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | n/a | yes |
