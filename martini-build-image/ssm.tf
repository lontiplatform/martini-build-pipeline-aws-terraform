resource "aws_ssm_parameter" "martini_build_image" {
  name  = var.parameter_name
  type  = "SecureString"

  value = jsonencode({
    MARTINI_VERSION = var.martini_version
    AWS_REGION      = var.aws_region
    AWS_ACCOUNT_ID  = var.aws_account_id
    ECR_REPO_NAME   = var.ecr_repo_name
  })

  description = "SSM parameter for Martini build image configurations"

  tags = merge(
    {
      Environment = var.environment
      Project     = "Martini"
    },
    var.tags
  )
}
