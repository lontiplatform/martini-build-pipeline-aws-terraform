resource "aws_ssm_parameter" "martini_build_image" {
  name  = var.parameter_name
  type  = "SecureString"

  value = jsonencode({
    MARTINI_VERSION = var.martini_version
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
