# Resource Block: Random String
resource "random_string" "suffix" {
  length  = 16
  special = false
  upper   = false
}

# Resource Block: AWS S3 Bucket
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "devopsdemo-${random_string.suffix.result}"

  tags = {
    Project     = "retail-store-sample-app"
    Environment = "Dev"
    Owner       = "Chandan Mondal"
  }
}