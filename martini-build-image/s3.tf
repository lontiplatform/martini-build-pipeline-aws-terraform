resource "aws_s3_bucket" "codebuild_artifacts" {
  bucket        = "${var.environment}-${var.pipeline_name}-s3-artifacts"
  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "codebuild_artifacts_encryption" {
  bucket = aws_s3_bucket.codebuild_artifacts.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = "alias/aws/s3"
    }
  }
}
