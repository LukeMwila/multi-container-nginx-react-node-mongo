resource "aws_s3_bucket" "main" {
  force_destroy = true
  acl           = "private"
  bucket = "${var.bucket_name}-${var.environment}"
  region        = var.region
  versioning {
    enabled = true
  }
}