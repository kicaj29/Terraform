provider "aws" {
  version = "~>3.0"
  region  = "us-west-1"
  profile = "infra-priv"
  assume_role {
    role_arn = "arn:aws:iam::026710611111:role/@Infra"
    duration_seconds = 900
  }
}

resource "aws_s3_bucket" "bucket1" {
  bucket = "bucket-jacek-test-1"
}

resource "aws_s3_bucket" "bucket2" {
  bucket = "bucket-jacek-test-2"
  depends_on = [aws_s3_bucket.bucket1]
}

resource "aws_s3_bucket" "bucket3" {
  bucket = "bucket-jacek-test-3"
  depends_on = [aws_s3_bucket.bucket2]
}

resource "time_sleep" "wait_some_time" {
  depends_on = [aws_s3_bucket.bucket3]

  create_duration  = "1000s"
}

resource "aws_s3_bucket" "bucket4" {
  bucket = "bucket-jacek-test-4"
  depends_on = [time_sleep.wait_some_time]
}

resource "aws_s3_bucket" "bucket5" {
  bucket = "bucket-jacek-test-5"
  depends_on = [aws_s3_bucket.bucket4]
}

resource "aws_s3_bucket" "bucket6" {
  bucket = "bucket-jacek-test-6"
  depends_on = [aws_s3_bucket.bucket5]
}

resource "time_sleep" "wait_some_time1" {
  depends_on = [aws_s3_bucket.bucket6]

  create_duration  = "1000s"
}

resource "aws_s3_bucket" "bucket7" {
  bucket = "bucket-jacek-test-7"
  depends_on = [time_sleep.wait_some_time1]
}

resource "aws_s3_bucket" "bucket8" {
  bucket = "bucket-jacek-test-8"
  depends_on = [aws_s3_bucket.bucket7]
}