# CodeBuild Service Role and Policy
resource "aws_iam_role" "codebuild_role" {
  name = "${var.environment}-${var.pipeline_name}-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "CodeBuildPolicy"
  role   = aws_iam_role.codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # SSM Parameter permissions
      {
        Effect   = "Allow",
        Action   = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ],
        Resource = aws_ssm_parameter.martini_build_image.arn
      },
      # ECR Permissions
      {
        Effect   = "Allow",
        Action   = "ecr:GetAuthorizationToken",
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ],
        Resource = aws_ecr_repository.martini_repository.arn
      },
      # CloudWatch Logs Permissions
      {
        Effect   = "Allow",
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "${aws_cloudwatch_log_group.martini_project_log_group.arn}:*"
      },
      # S3 Artifact Permissions
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = "${aws_s3_bucket.codebuild_artifacts.arn}/*"
      },
      # CodePipeline Trigger Permissions
      {
        Effect   = "Allow",
        Action   = [
          "codepipeline:StartPipelineExecution"
        ],
        Resource = aws_codepipeline.martini_pipeline.arn
      },
      # CodeStar Connection Permissions
      {
        Effect   = "Allow",
        Action   = [
          "codestar-connections:GetConnectionToken",
          "codestar-connections:GetConnection",
          "codestar-connections:UseConnection"
        ],
        Resource = var.connection_arn
      }
    ]
  })
}

# CodePipeline Service Role and Policy
resource "aws_iam_role" "codepipeline_role" {
  name = "${var.environment}-${var.pipeline_name}-codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "codepipeline.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "CodePipelinePolicy"
  role   = aws_iam_role.codepipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # Permissions to start and manage CodeBuild
      {
        Effect   = "Allow",
        Action   = [
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds"
        ],
        Resource = aws_codebuild_project.martini_project.arn
      },
      # Permissions to interact with S3 for artifacts
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = "${aws_s3_bucket.codebuild_artifacts.arn}/*"
      },
      # CodePipeline Permissions
      {
        Effect   = "Allow",
        Action   = [
          "codepipeline:StartPipelineExecution",
          "codepipeline:GetPipelineState",
          "codepipeline:GetPipelineExecution",
          "codepipeline:GetPipeline",
          "codepipeline:ListPipelineExecutions",
          "codepipeline:RetryStageExecution"
        ],
        Resource = aws_codepipeline.martini_pipeline.arn
      },
      # CodeStar Connection Permissions
      {
        Effect   = "Allow",
        Action   = [
          "codestar-connections:GetConnectionToken",
          "codestar-connections:GetConnection",
          "codestar-connections:UseConnection"
        ],
        Resource = var.connection_arn
      }
    ]
  })
}

# KMS Permissions for CodePipeline
resource "aws_iam_role_policy" "codepipeline_kms_policy" {
  name   = "CodePipelineKMSPolicy"
  role   = aws_iam_role.codepipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey",
          "kms:DescribeKey"
        ],
        Resource = "arn:aws:kms:${var.aws_region}:${data.aws_caller_identity.current.account_id}:alias/aws/s3"
      }
    ]
  })
}
