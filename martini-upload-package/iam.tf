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
        Resource = "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/${var.parameter_name}"
      },
       # CloudWatch Logs Permissions
      {
        Effect   = "Allow",
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.environment}-${var.pipeline_name}-codebuild*"
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
        Resource = aws_codepipeline.codepipeline_name.arn
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
        Resource = aws_codebuild_project.codebuild_name.arn
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
        Resource = aws_codepipeline.codepipeline_name.arn
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
