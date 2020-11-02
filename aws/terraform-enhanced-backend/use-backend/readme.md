# terraform init

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

# workspace demo1

## create new workspace demo1
```
PS D:\GitHub\kicaj29\Terraform\aws\terraform-enhanced-backend\use-backend> terraform workspace new demo1
Created and switched to workspace "demo1"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
PS D:\GitHub\kicaj29\Terraform\aws\terraform-enhanced-backend\use-backend> terraform workspace list
  default
* demo1
```

## verify plan for demo1
```
PS D:\GitHub\kicaj29\Terraform\aws\terraform-enhanced-backend\use-backend> terraform plan -out demo1-state.tfplan
Acquiring state lock. This may take a few moments...
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.example will be created
  + resource "aws_instance" "example" {
      + ami                          = "ami-0e4035ae3f70c400f"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + network_interface_id         = (known after apply)
      + outpost_arn                  = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "Name" = "demo1-jackcompany"
        }
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: demo1-state.tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "demo1-state.tfplan"

Releasing state lock. This may take a few moments...
```

## execute plan for demo1
```
PS D:\GitHub\kicaj29\Terraform\aws\terraform-enhanced-backend\use-backend> terraform apply demo1-state.tfplan
Acquiring state lock. This may take a few moments...
aws_instance.example: Creating...
aws_instance.example: Still creating... [10s elapsed]
aws_instance.example: Still creating... [20s elapsed]
aws_instance.example: Creation complete after 30s [id=i-0baf03b8537506fa1]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
Releasing state lock. This may take a few moments...
```

# workspace demo2
Repeat the same steps from second workspace.

```
terraform workspace new demo2
terraform plan -out demo2-state.tfplan
terraform apply demo2-state.tfplan
```

# destroy demo1

>NOTE: "The behavior of any terraform destroy command can be previewed at any time with an equivalent terraform plan -destroy command."

```
PS D:\GitHub\kicaj29\Terraform\aws\terraform-enhanced-backend\use-backend> terraform destroy
Acquiring state lock. This may take a few moments...
aws_instance.example: Refreshing state... [id=i-0baf03b8537506fa1]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_instance.example will be destroyed
  - resource "aws_instance" "example" {
      - ami                          = "ami-0e4035ae3f70c400f" -> null
      - arn                          = "arn:aws:ec2:us-west-1:633883526719:instance/i-0baf03b8537506fa1" -> null
      - associate_public_ip_address  = true -> null
      - availability_zone            = "us-west-1c" -> null
      - cpu_core_count               = 1 -> null
      - cpu_threads_per_core         = 1 -> null
      - disable_api_termination      = false -> null
      - ebs_optimized                = false -> null
      - get_password_data            = false -> null
      - hibernation                  = false -> null
      - id                           = "i-0baf03b8537506fa1" -> null
      - instance_state               = "running" -> null
      - instance_type                = "t2.micro" -> null
      - ipv6_address_count           = 0 -> null
      - ipv6_addresses               = [] -> null
      - monitoring                   = false -> null
      - primary_network_interface_id = "eni-03820ac541a53bbfc" -> null
      - private_dns                  = "ip-172-31-5-225.us-west-1.compute.internal" -> null
      - private_ip                   = "172.31.5.225" -> null
      - public_dns                   = "ec2-54-215-126-6.us-west-1.compute.amazonaws.com" -> null
      - public_ip                    = "54.215.126.6" -> null
      - security_groups              = [
          - "default",
        ] -> null
      - source_dest_check            = true -> null
      - subnet_id                    = "subnet-240bc77e" -> null
      - tags                         = {
          - "Name" = "demo1-jackcompany"
        } -> null
      - tenancy                      = "default" -> null
      - volume_tags                  = {} -> null
      - vpc_security_group_ids       = [
          - "sg-76949a02",
        ] -> null

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      - metadata_options {
          - http_endpoint               = "enabled" -> null
          - http_put_response_hop_limit = 1 -> null
          - http_tokens                 = "optional" -> null
        }



      - root_block_device {
          - delete_on_termination = true -> null
          - device_name           = "/dev/xvda" -> null
          - encrypted             = false -> null
          - iops                  = 100 -> null
          - volume_id             = "vol-00d64368e10d7fae0" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp2" -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources in workspace "demo1"?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.example: Destroying... [id=i-0baf03b8537506fa1]
aws_instance.example: Still destroying... [id=i-0baf03b8537506fa1, 10s elapsed]
aws_instance.example: Still destroying... [id=i-0baf03b8537506fa1, 20s elapsed]
aws_instance.example: Still destroying... [id=i-0baf03b8537506fa1, 30s elapsed]
aws_instance.example: Still destroying... [id=i-0baf03b8537506fa1, 40s elapsed]
aws_instance.example: Destruction complete after 44s

Destroy complete! Resources: 1 destroyed.
Releasing state lock. This may take a few moments...
```
# destroy demo2