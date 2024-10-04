terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
  }
   backend "s3" {
    bucket = "terraform-state-restaurant-app"     # Replace with your S3 bucket name
    key    = "terraform/my-terraform.tfstate" # Path to store the state file in S3
    region = "eu-west-3"                # Your AWS region
  }
}
provider "aws" {
  region = "eu-west-3"
}



resource "aws_instance" "my_ec2" {
  ami           = "ami-045a8ab02aadf4f88"  # Example AMI
  instance_type = "t2.micro"
}