# Martini AWS CI/CD Pipeline

This repository provides Terraform modules to configure AWS CodePipelines for automating workflows related to Martini applications. The modules streamline CI/CD processes, enabling consistent and secure deployment of Martini server runtimes and packages.

## Overview

The repository includes Terraform modules to address two primary workflows:

1. **Build Docker Images**: Automates the process of creating Docker images containing the Martini Server Runtime and associated packages, and pushes them to Amazon Elastic Container Registry (ECR).
   - Uses the `martini-build-image` module and its corresponding buildspec (`martini-build-image.yaml`)
   - Docker image definition is handled in the `Dockerfile`.

2. **Upload Martini Packages**: Facilitates zipping and uploading Martini packages to specified Martini instances.
   - Uses the `martini-upload-package` module and the `martini-upload-package.yaml` buildspec.
   - Execution logic handled by `upload_packages.sh`, a reusable shell script.

## Why GitHub instead of CodeCommit?

AWS deprecated CodeCommit in favor of broader integrations with GitHub, GitLab, and Bitbucket using AWS CodeStar Connections. This repository uses GitHub, integrated via an AWS-managed GitHub App, which simplifies source control for Martini projects in modern CI/CD pipelines.

## AWS Services Used

- **CodePipeline**: Automates CI/CD processes by orchestrating source, build, and deploy stages.  
- **CodeBuild**: Builds and tests Martini projects using predefined buildspec files.  
- **Elastic Container Registry (ECR)**: Manages Docker images for Martini applications.  
- **Systems Manager Parameter Store**: Secures sensitive configurations and credentials.  
- **S3**: Stores build artifacts securely with encryption and lifecycle policies.  
- **CloudWatch**: Provides logging and monitoring for pipeline and build processes.  
- **IAM**: Manages roles and permissions for pipeline, build, and other AWS services.  
- **CodeStar Connections**: Facilitates secure integration with GitHub repositories.  

**Note**: CodeStar Connections - The connection must be created manually in the AWS Management Console due to the required authentication flow with the external platform. Once created, it generates a Connection ARN that can be referenced in automation tools like Terraform.

## Project Structure

The repository includes the following templates:

- **`martini-build-image`**: Terraform module for building Docker images for Martini.
  - Relies on: `martini-build-image.yaml` (buildspec), `Dockerfile`

- **`martini-upload-package`**: Terraform module for uploading Martini packages to an instance.
  - Relies on: `martini-upload-package.yaml` (buildspec), `upload_packages.sh`

## References

- [Martini Documentation](https://developer.lonti.com/docs/martini)
- [Martini CodePipeline Documentation](https://developer.lonti.com/docs/martini/cicd/automated-deployment/aws-codepipeline)
- [AWS CodePipeline Documentation](https://docs.aws.amazon.com/codepipeline)
- [Terraform Documentation](https://www.terraform.io/docs)
