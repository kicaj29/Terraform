- [create infrastructure for terraform backend](#create-infrastructure-for-terraform-backend)
  - [terraform init for backend](#terraform-init-for-backend)
  - [terraform plan for backend](#terraform-plan-for-backend)
  - [terraform apply for backend](#terraform-apply-for-backend)
  - [terraform destroy for backend](#terraform-destroy-for-backend)
- [use terraform backend](#use-terraform-backend)
  - [terraform init - connect with pointed backend](#terraform-init---connect-with-pointed-backend)
  - [create new workspace demo1](#create-new-workspace-demo1)
- [resources](#resources)

# create infrastructure for terraform backend

[Backend types](https://www.terraform.io/docs/backends/types/index.html):
* standard
* enhanced

Terraform for this part does not use backend to store its state in AWS because it creates the backend.

## terraform init for backend

Terraform init will download necessary plugin for AWS provider.

```
PS D:\GitHub\kicaj29\Terraform\aws\terraform-enhanced-backend\create-backend-infra> terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/local...
- Finding hashicorp/aws versions matching "~> 2.0"...
- Finding latest version of hashicorp/random...
- Installing hashicorp/local v2.0.0...
- Installed hashicorp/local v2.0.0 (signed by HashiCorp)
- Installing hashicorp/aws v2.70.0...
- Installed hashicorp/aws v2.70.0 (signed by HashiCorp)
- Installing hashicorp/random v3.0.0...
- Installed hashicorp/random v3.0.0 (signed by HashiCorp)

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, we recommend adding version constraints in a required_providers block
in your configuration, with the constraint strings suggested below.

* hashicorp/local: version = "~> 2.0.0"
* hashicorp/random: version = "~> 3.0.0"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

## terraform plan for backend

```
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

## terraform apply for backend

It will create new local file ```output.json``` that contains IDs needed to use this created backend.
This command also creates new bucket and dynamoDB table as infrastructure for backend state.

```
PS D:\GitHub\kicaj29\Terraform\aws\terraform-enhanced-backend\create-backend-infra> terraform apply state.tfplan
random_integer.rand: Creating...
random_integer.rand: Creation complete after 0s [id=50879]
aws_s3_bucket.state_bucket: Creating...
aws_dynamodb_table.terraform_statelock: Creating...
aws_dynamodb_table.terraform_statelock: Creation complete after 9s [id=jackcompany-tfstatelock-50879]
aws_s3_bucket.state_bucket: Still creating... [10s elapsed]
aws_s3_bucket.state_bucket: Creation complete after 14s [id=jackcompany-50879]
local_file.user_data_json: Creating...
local_file.user_data_json: Creation complete after 0s [id=bf66441691cab5e715516deafff7b447fc36e74a]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: terraform.tfstate

Outputs:

dynamodb_statelock = jackcompany-tfstatelock-50879
s3_bucket = jackcompany-50879
```

## terraform destroy for backend
TBD

# use terraform backend

## terraform init - connect with pointed backend

Terraform init will download necessary plugin for AWS provider and will connect with terraform backend state infrastructure.
>NOTE: it is also possible to pass backend params directly to ```terraform init``` command.

```
PS D:\GitHub\kicaj29\Terraform\aws\terraform-enhanced-backend\use-backend> terraform init

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 2.0"...
- Installing hashicorp/aws v2.70.0...
- Installed hashicorp/aws v2.70.0 (signed by HashiCorp)

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

**At this moment s3 and dynamo table are still empty:**

![01-s3-empty.png](images/01-s3-empty.png)
![02-dynamo-empty.png](images/02-dynamo-empty.png)

## create new workspace demo1

```
PS D:\GitHub\kicaj29\Terraform\aws\terraform-enhanced-backend\use-backend> terraform workspace new demo1
Created and switched to workspace "demo1"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
```

It means that state file has been created and new row was added into dynamoDB table.

![03-s3-new-file.png](images/03-s3-new-file.png)
![04-dynamo-new-row.png](images/04-dynamo-new-row.png)

# resources

https://app.pluralsight.com/library/courses/implementing-terraform-aws/table-of-contents   
https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa   
https://www.terraform.io/docs/backends/types/s3.html   
https://discuss.hashicorp.com/t/how-to-use-templatefile-when-writing-terraform-files-in-json/1906/2