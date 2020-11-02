terraform {
    backend "s3" {
        bucket  = "jackcompany-46227"
        dynamodb_table = "jackcompany-tfstatelock-46227"
        key = "terraform.tfstate"
        region = "us-west-1"
        profile = "sandbox-svc-terrafrom-jacek"
    }
}