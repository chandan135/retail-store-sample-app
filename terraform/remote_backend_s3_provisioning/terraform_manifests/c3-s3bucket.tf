# Resource Block: Random String
resource "random_string" "suffix" {
  length  = 16
  special = false
  upper   = false
}

# Resource Block: AWS S3 Bucket
resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "tfstate-${var.environment_name}-${var.aws_region}-${random_string.suffix.result}"
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name        = "tfstate-${var.environment_name}-${var.aws_region}"
    Environment = "Dev"
    Project     = "retail-store-sample-app"
    Purpose     = "terraform-backend-bucket"
    Terraform   = "true"
  }
}

# S3 Bucket Versioning
resource "aws_s3_bucket_versioning" "tfstate_bucket_versioning" {
  bucket = aws_s3_bucket.tfstate_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable SSE
resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_bucket_encryption" {
  bucket = aws_s3_bucket.tfstate_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block Public Access
resource "aws_s3_bucket_public_access_block" "tfstate_bucket_block_public_access" {
  bucket = aws_s3_bucket.tfstate_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}