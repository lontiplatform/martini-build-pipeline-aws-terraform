
resource "aws_s3_bucket" "codebuild_artifacts" {
  bucket = local.project_name_s3  # S3 bucket for CodeBuild artifacts

  force_destroy = true  # Force delete the bucket even if it has objects

  tags = var.tags  # Apply tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "codebuild_artifacts_encryption" {
  bucket = aws_s3_bucket.codebuild_artifacts.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"  # Use AWS KMS for encryption
      kms_master_key_id = "alias/aws/s3"  # Default KMS key for S3
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "codebuild_artifacts_lifecycle" {
  bucket = aws_s3_bucket.codebuild_artifacts.bucket

  rule {
    id     = "lifecycle-rule"  # Lifecycle rule ID
    status = "Enabled"  # Enable the lifecycle rule

    expiration {
      days = 90  # Expire objects after 90 days
    }

    noncurrent_version_expiration {
      noncurrent_days = 30  # Expire noncurrent versions after 30 days
    }
  }
}

resource "aws_s3_bucket_versioning" "codebuild_artifacts_versioning" {
  bucket = aws_s3_bucket.codebuild_artifacts.id

  versioning_configuration {
    status = "Enabled"  # Enable versioning
  }
}
