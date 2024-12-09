resource "aws_ecr_repository" "martini_repository" {
  name                 = "${var.environment}-${var.pipeline_name}-martini-repo"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  
  tags = var.tags
  force_delete = true
}