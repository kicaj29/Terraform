aws credentials have been set in .credentials file like this - these are credentials of a user that assume a role in terraform code:

[infra-priv]
aws_access_key_id = XXX
aws_secret_access_key = YYY

Also this user does not have any permissions and the role has set trusted relationship directly for this user:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::026710611111:root",
          "arn:aws:iam::026710611111:user/deployer"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```