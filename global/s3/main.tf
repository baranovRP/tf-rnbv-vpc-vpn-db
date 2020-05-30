###
# purpose of the s3 module
# - create storage for terraform's remote state
# - create lock mechanism for terraform state
###
provider "aws" {
  version = "~> 2.0"
  region  = "eu-central-1"
}

terraform {
  required_version = "~> v0.12"

  backend "s3" {
    bucket = "tf-state-eu-central-1-ora2postgres"
    key    = "global/s3/terraform.tfstate"
    region = "eu-central-1"

    dynamodb_table = "tf-locks-eu-central-1-ora2postgres"
    encrypt        = true
  }
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "tf-state-eu-central-1-ora2postgres"
  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "tf_locks" {
  name         = "tf-locks-eu-central-1-ora2postgres"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

