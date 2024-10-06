terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
  }
   backend "s3" {
    bucket = "terraform-state-restaurant-app"    
    key    = "terraform/my-terraform.tfstate"
    region = "eu-west-3"        
  }
}
provider "aws" {
  region = "eu-west-3"
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}


module "subnets" {
  for_each            = var.subnets
  source              = "./modules/subnet"
  vpc_id              = module.vpc.my_vpc.id
  cidr_block          = each.value.cidr_block
  availability_zone   = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  type                = each.value.type
  key                 = each.value.key
}


module "subnets" {
  for_each            = var.subnets
  source              = "./modules/subnet"
  vpc_id              = module.vpc.my_vpc.id
  cidr_block          = each.value.cidr_block
  availability_zone   = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  type                = each.value.type
  key                 = each.value.key
}

module "gateways" {
  source          = "./modules/gateways"
  vpc_id          = module.vpc.my_vpc.id
  public_subnet_id = module.public_subnet_1.mysubnet.id
}


module "public_route_table" {
  source           = "./modules/public-route"
}

module "private_route_table" {
  source           = "./modules/private-route"
}
module "security_groups" {
  source  = "./modules/security"
}

module "ec2" {
  for_each      = var.instances
  ami           = each.value.ami
  instance_type = each.value.instance_type
  instance_name = each.value.instance_name
  source ="./modules/ec2"
}
