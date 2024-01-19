provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "your-unique-bucket-name"  # Replace with a globally unique bucket name

  acl    = "private"  # You can set the ACL as needed (private, public-read, public-read-write, etc.)

  tags = {
    Name = "MyS3Bucket"
    Environment = "Production"
  }

  force_destroy = true  # This will allow Terraform to destroy the bucket on removal from configuration

  versioning {
    enabled = true  # Enable versioning for the bucket
  }

  lifecycle_rule {
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
}

