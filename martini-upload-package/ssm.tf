resource "aws_ssm_parameter" "martini_upload_package" {
  name  = var.parameter_name
  type  = "SecureString"

  value = jsonencode({
    BASE_URL                   = var.base_url
    MARTINI_ACCESS_TOKEN       = var.martini_access_token
    PACKAGE_NAME_PATTERN       = var.package_name_pattern
    PACKAGE_DIR                = var.package_dir
    ASYNC_UPLOAD               = var.async_upload
    SUCCESS_CHECK_TIMEOUT      = var.success_check_timeout
    SUCCESS_CHECK_DELAY        = var.success_check_delay
    SUCCESS_CHECK_PACKAGE_NAME = var.success_check_package_name
  })

  description = "SSM parameter for Martini upload-package configuration"

  tags = merge(
    {
      Environment = var.environment
      Project     = "Martini"
    },
    var.tags
  )
}
