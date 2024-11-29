# Martini AWS CI/CD Pipeline

This repository contains Terraform configurations to deploy a CI/CD pipeline on AWS for **Martini**—a low-code platform for API management, business process automation, and data integration. With Martini, developers can automate workflows, build APIs, and integrate applications using both visual tools and custom scripting.

## Martini Overview

Martini simplifies API development, business process automation, and data integration through a low-code interface, while still providing developers the option to implement custom logic when needed. Martini supports flexible deployments on the cloud, on-premise, or locally, and excels at managing complex workflows with robust security and integration capabilities.

## Why GitHub instead of CodeCommit?

AWS deprecated CodeCommit in favor of broader integrations with GitHub, GitLab, and Bitbucket using AWS CodeStar Connections. This repository uses GitHub, integrated via an AWS-managed GitHub App, which simplifies source control for Martini projects in modern CI/CD pipelines.

For more details, check out the [Martini Knowledge Base](https://support.lonti.com/martini).

## AWS Services Used

- **CodeBuild**: Builds and tests Martini projects using predefined buildspec files.
- **CodePipeline**: Orchestrates CI/CD by automating code fetching from GitHub, building, and deploying Martini projects.
- **S3**: Stores build artifacts securely with encryption and lifecycle policies.
- **CloudWatch**: Provides logging and monitoring for build and pipeline processes.
- **IAM**: Manages roles and permissions for CodeBuild, CodePipeline, and related services.

## Project Structure

The repository includes the following Terraform files:

- `cloudwatch.tf`: Sets up CloudWatch log groups for build and pipeline monitoring.
- `codebuild.tf`: Configures CodeBuild to compile and test Martini integrations.
- `codepipeline.tf`: Defines CodePipeline for managing CI/CD stages, linked to GitHub.
- `erc.tf`: Manages the Elastic Container Registry (ECR) for storing Martini Docker images.
- `iam.tf`: Manages IAM roles and policies for CodeBuild, CodePipeline, and other AWS services.
- `main.tf`: Sets the AWS provider and dynamic naming conventions.
- `outputs.tf`: Exports key resource ARNs (e.g., CodeBuild project, CodePipeline).
- `s3.tf`: Configures an S3 bucket for build artifacts with KMS encryption.
- `ssm.tf`: Defines parameters for secure storage of sensitive configuration values in AWS Systems Manager Parameter Store.
- `variable.tf`: Declares variables with validations and detailed descriptions (e.g., `base_url`, `martini_user_name`, `martini_user_password`).

## Deployment

To deploy the CI/CD pipeline:

1. Clone the repository.
2. Ensure AWS CLI and Terraform are installed.
3. Fill in `terraform.tfvars` with your specific environment values.
4. Initialize Terraform:
   ```bash
   terraform init
   ```
5. Review the execution plan:
   ```bash
   terraform plan
   ```
6. Apply the configuration:
   ```bash
   terraform apply
   ```

## Additional Notes

- **Debugging**: Use CloudWatch logs to troubleshoot build and pipeline errors.
- **Retention Policies**: Log groups created in CloudWatch have a customizable retention period defined in `variable.tf`.
- **SSM Parameters**: Securely store sensitive values, such as Martini user credentials, using AWS Systems Manager Parameter Store.

