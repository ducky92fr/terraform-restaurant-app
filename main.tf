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
  vpc_name = "my-main-vpc"
}

module "subnets" {
  for_each            = var.subnets
  source              = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
  cidr_block          = each.value.cidr_block
  availability_zone   = each.value.availability_zone
  map_public_ip_on_launch = each.value.public_ip_on_launch
  type                = each.value.type
  key                 = each.value.key
}
module "internet_gateway" {
  source              = "./modules/internet-gateway"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_name = "my-internet-gateway"
}


module "nat_gateway" {
  source           = "./modules/nat-gateway"
  public_subnet_id = lookup(
  { for k, v in module.subnets : k => v.mysubnet.id if can(regex("public", v.mysubnet.tags.Name)) },
  "public_subnet_1"
)
  nat_gateway_name = "my-nat-gateway"
}






# module "public_route_table" {
#   source           = "./modules/public-route"
# }

# module "private_route_table" {
#   source           = "./modules/private-route"
# }

# module "security_groups" {
#   source  = "./modules/security"
# }

# module "ec2" {
#   for_each      = var.instances
#   ami           = each.value.ami
#   instance_type = each.value.instance_type
#   instance_name = each.value.instance_name
#   source ="./modules/ec2"
# }
