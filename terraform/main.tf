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
    dynamodb_table = "terraform-state-lock"  
    encrypt        = true        
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
  public_subnet_id = module.subnets["public_subnet_1"].subnet_id
  nat_gateway_name = "my-nat-gateway"
}



module "public_route_table" {
  source           = "./modules/public-route"
  vpc_id=module.vpc.vpc_id
  gateway_id=module.internet_gateway.internet_gateway_id
  public_subnet_id = module.subnets["public_subnet_1"].subnet_id
}

module "private_route_table" {
  source           = "./modules/private-route"
  vpc_id=module.vpc.vpc_id
  nat_gateway_id = module.nat_gateway.nat_gateway_id
  private_subnet_id = module.subnets["private_subnet_1"].subnet_id
}

module "security_groups" {
  for_each = var.securities

  source = "./modules/security"
  vpc_id              = module.vpc.vpc_id
  name                = each.key  
  ingress_from_port   = each.value.ingress_from_port
  ingress_to_port     = each.value.ingress_to_port
  protocol            = each.value.protocol
  ingress_cidr_blocks = each.value.ingress_cidr_blocks
  egress_from_port    = each.value.egress_from_port
  egress_to_port      = each.value.egress_to_port
  egress_protocol     = each.value.egress_protocol
  egress_cidr_blocks  = each.value.egress_cidr_blocks
  tagName             = each.value.tagName
}

module "ec2" {
  for_each      = var.instances
  ami           = each.value.ami
  instance_type = each.value.instance_type
  instance_name = each.value.instance_name
  key_name = each.value.key_name
  subnet_id=module.subnets[each.value.subnet].subnet_id
  source ="./modules/ec2"
  associate_public_ip_address = true
  vpc_security_group_ids=[module.security_groups["http"].security_group_id,module.security_groups["ssh"].security_group_id]
}


resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.yml"
  content  = templatefile("${path.module}/../ansible/templates/inventory.tpl", {
    ec2_ips = {
      for key, instance in module.ec2 :
      key => {
        public_ip  = instance.public_ip
        private_ip = instance.private_ip
        subnet_type = instance.subnet_id == module.subnets["public_subnet_1"].subnet_id ? "public" : "private"
      }
    }
  })
   depends_on = [module.ec2]
}