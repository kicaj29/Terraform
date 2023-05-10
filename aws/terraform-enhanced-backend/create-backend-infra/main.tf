##################################################################################
# VARIABLES
##################################################################################

variable "region" {
  type    = string
  default = "us-west-1"
}

#Bucket variables
variable "aws_bucket_prefix" {
  type    = string
  default = "jackcompany"
}

variable "aws_dynamodb_table" {
  type    = string
  default = "jackcompany-tfstatelock"
}


##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  version = "~>3.0"
  region  = var.region
  profile = "infra-priv"
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
  hash_key       = "LockID"     #It is requirement to use this value to have working terraform backend with s3 and dynamodb

  attribute {
    name = "LockID"             #It is requirement to use this value to have working terraform backend with s3 and dynamodb       
    type = "S"                  #It is requirement to use this value to have working terraform backend with s3 and dynamodb (S means string)
  }
}

resource "local_file" "user_data_json" {
  content = templatefile("output_template.json", {
    s3_bucket                       = aws_s3_bucket.state_bucket.bucket
    dynamodb_statelock              = aws_dynamodb_table.terraform_statelock.name
    }
  )
  filename = "output.json"
}

resource "aws_s3_bucket" "state_bucket" {
  bucket        = local.bucket_name
  acl           = "private"
  force_destroy = true          #it makes possible to delete the bucket even it is not empty (in production env. we might want set it to false)

  versioning {
    enabled = true
  }

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