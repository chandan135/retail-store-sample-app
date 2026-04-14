output "tfstate_bucket_arn" {
  value       = aws_s3_bucket.tfstate_bucket.arn
  description = "tfstate bucket arn"
}

output "tfstate_bucket_id" {
  value       = aws_s3_bucket.tfstate_bucket.id
  description = "tfstate bucket id"
}