terraform {
    backend "s3" {
        bucket  = "jackcompany-23769"
        dynamodb_table = "jackcompany-tfstatelock-23769"
        key = "terraform.tfstate"
        region = "us-west-1"
        profile = "infra-priv"
        role_arn = "arn:aws:iam::026710611111:role/@Infra"
    }
}