terraform {
    backend "s3" {
        bucket  = "jackcompany-50879"
        dynamodb_table = "jackcompany-tfstatelock-50879"
        key = "terraform.tfstate"
        region = "us-west-1"
        profile = "sandbox-svc-terrafrom-jacek"
    }
}