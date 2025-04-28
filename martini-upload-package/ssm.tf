resource "aws_ssm_parameter" "martini_upload_package" {
  name = var.parameter_name
  type = "SecureString"
  value = jsonencode({
    BASE_URL              = var.base_url
    MARTINI_ACCESS_TOKEN  = var.martini_access_token
    ALLOWED_PACKAGES      = var.allowed_packages
  })
  description = "SSM parameter for Martini build image configurations"
  tags = {
    Environment = var.environment
    Project     = "Martini"
  }
}
  