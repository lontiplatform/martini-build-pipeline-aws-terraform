resource "aws_ssm_parameter" "martini_upload_package" {
  name = var.parameter_name
  type = "SecureString"
  value = jsonencode({
    BASE_URL              = var.base_url
    MARTINI_USER_NAME     = var.martini_user_name
    MARTINI_USER_PASSWORD = var.martini_user_password
  })
  description = "SSM parameter for Martini build image configurations"
  tags = {
    Environment = var.environment
    Project     = "Martini"
  }
}
  