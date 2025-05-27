resource "aws_ecr_repository" "martini_repository" {
  name                 = local.name_prefix
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true
  tags         = var.tags
}
