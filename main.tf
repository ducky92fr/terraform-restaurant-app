terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
  }
}
provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-045a8ab02aadf4f88"  # Example AMI
  instance_type = "t2.micro"
}