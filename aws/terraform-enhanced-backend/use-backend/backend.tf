terraform {
    backend "s3" {
        bucket  = "jackcompany-57015"
        dynamodb_table = "jackcompany-tfstatelock-57015"
        key = "terraform.tfstate"
        region = "us-west-1"
        profile = "default"
    }
}