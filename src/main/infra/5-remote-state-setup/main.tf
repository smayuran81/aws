##################################################################################
# VARIABLES
##################################################################################

variable "region" {
  type    = string
  default = "eu-west-1"
}

#Bucket variables
variable "aws_bucket_prefix" {
  type    = string
  default = "mayuran-aws"
}

variable "aws_dynamodb_table" {
  type    = string
  default = "mayuran-aws-tfstatelock"
}

variable "full_access_users" {
  type    = list(string)
  default = []

}

variable "read_only_users" {
  type    = list(string)
  default = []
}

##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  region  = var.region
}

##################################################################################
# RESOURCES
##################################################################################

resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

locals {

  dynamodb_table_name = "${var.aws_dynamodb_table}-${random_integer.rand.result}"
  bucket_name         = "${var.aws_bucket_prefix}-${random_integer.rand.result}"
}

resource "aws_dynamodb_table" "terraform_statelock" {
  name           = local.dynamodb_table_name
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "state_bucket" {
  bucket        = local.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_acl" "state_bucket" {

  depends_on = [aws_s3_bucket_ownership_controls.state_bucket]
  bucket = aws_s3_bucket.state_bucket.id
 acl    = "private"

}

resource "aws_s3_bucket_ownership_controls" "state_bucket" {
  bucket = aws_s3_bucket.state_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "stat_bucket" {
  bucket = aws_s3_bucket.state_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "state_bucket" {
  bucket = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_group" "bucket_full_access" {

  name = "${local.bucket_name}-full-access"

}

resource "aws_iam_group" "bucket_read_only" {

  name = "${local.bucket_name}-read-only"

}

# Add members to the group

resource "aws_iam_group_membership" "full_access" {
  name = "${local.bucket_name}-full-access"

  users = var.full_access_users

  group = aws_iam_group.bucket_full_access.name
}

resource "aws_iam_group_membership" "read_only" {
  name = "${local.bucket_name}-read-only"

  users = var.read_only_users

  group = aws_iam_group.bucket_read_only.name
}

resource "aws_iam_group_policy" "full_access" {
  name  = "${local.bucket_name}-full-access"
  group = aws_iam_group.bucket_full_access.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${local.bucket_name}",
                "arn:aws:s3:::${local.bucket_name}/*"
            ]
        },
                {
            "Effect": "Allow",
            "Action": ["dynamodb:*"],
            "Resource": [
                "${aws_dynamodb_table.terraform_statelock.arn}"
            ]
        }
   ]
}
EOF
}

resource "aws_iam_group_policy" "read_only" {
  name  = "${local.bucket_name}-read-only"
  group = aws_iam_group.bucket_read_only.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": [
                "arn:aws:s3:::${local.bucket_name}",
                "arn:aws:s3:::${local.bucket_name}/*"
            ]
        }
   ]
}
EOF
}

##################################################################################
# OUTPUT
##################################################################################

output "s3_bucket" {
  value = aws_s3_bucket.state_bucket.bucket
}

output "dynamodb_statelock" {
  value = aws_dynamodb_table.terraform_statelock.name
}