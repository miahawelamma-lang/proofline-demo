terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "proofline_demo" {
  bucket = "proofline-demo-esther-2026"

  tags = {
    Name        = "Proofline Demo"
    Environment = "Testing"
  }
}

resource "aws_s3_bucket_public_access_block" "proofline_demo" {
  bucket = aws_s3_bucket.proofline_demo.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "proofline_demo" {
  bucket = aws_s3_bucket.proofline_demo.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
# Security review: public access is blocked and server-side encryption is enabled.
