# terraform init

Run ```terraform init``` to download terraform plugin for AWS.

# terraform plan

```terraform
PS D:\GitHub\kicaj29\Terraform\aws\terraform-enhanced-backend\create-backend-infra> terraform plan -out state.tfplan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_dynamodb_table.terraform_statelock will be created
  + resource "aws_dynamodb_table" "terraform_statelock" {
      + arn              = (known after apply)
      + billing_mode     = "PROVISIONED"
      + hash_key         = "LockID"
      + id               = (known after apply)
      + name             = (known after apply)
      + read_capacity    = 20
      + stream_arn       = (known after apply)
      + stream_label     = (known after apply)
      + stream_view_type = (known after apply)
      + write_capacity   = 20

      + attribute {
          + name = "LockID"
          + type = "S"
        }

      + point_in_time_recovery {
          + enabled = (known after apply)
        }

      + server_side_encryption {
          + enabled     = (known after apply)
          + kms_key_arn = (known after apply)
        }
    }

  # aws_s3_bucket.state_bucket will be created
  + resource "aws_s3_bucket" "state_bucket" {
      + acceleration_status         = (known after apply)
      + acl                         = "private"
      + arn                         = (known after apply)
      + bucket                      = (known after apply)
      + bucket_domain_name          = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = true
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + versioning {
          + enabled    = true
          + mfa_delete = false
        }
    }

  # local_file.user_data_json will be created
  + resource "local_file" "user_data_json" {
      + content              = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "output.json"
      + id                   = (known after apply)
    }

  # random_integer.rand will be created
  + resource "random_integer" "rand" {
      + id     = (known after apply)
      + max    = 99999
      + min    = 10000
      + result = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: state.tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "state.tfplan"
```
# terraform apply

```
PS D:\GitHub\kicaj29\Terraform\aws\terraform-enhanced-backend\create-backend-infra> terraform apply state.tfplan
random_integer.rand: Creating...
random_integer.rand: Creation complete after 0s [id=46227]
aws_s3_bucket.state_bucket: Creating...
aws_dynamodb_table.terraform_statelock: Creating...
aws_s3_bucket.state_bucket: Still creating... [10s elapsed]
aws_dynamodb_table.terraform_statelock: Still creating... [10s elapsed]
aws_dynamodb_table.terraform_statelock: Creation complete after 11s [id=jackcompany-tfstatelock-46227]
aws_s3_bucket.state_bucket: Creation complete after 13s [id=jackcompany-46227]
local_file.user_data_json: Creating...
local_file.user_data_json: Creation complete after 0s [id=ae6dcf0eee9e4baf8f620d9fba3b95fb87f89abd]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: terraform.tfstate

Outputs:

dynamodb_statelock = jackcompany-tfstatelock-46227
s3_bucket = jackcompany-46227
```

# terraform destroy

TBD

# resources
https://discuss.hashicorp.com/t/how-to-use-templatefile-when-writing-terraform-files-in-json/1906/2   
