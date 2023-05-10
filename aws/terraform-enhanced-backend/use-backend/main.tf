provider "aws" {
  version = "~>3.0"
  region  = "us-west-1"
  profile = "default"
}

resource "aws_instance" "example" {
  ami           = "ami-0e4035ae3f70c400f"
  instance_type = var.ec2_instance_type
  tags = {
    Name = "${terraform.workspace}-jackcompany"
  }
}