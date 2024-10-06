instances = {
  "my-haproxy"        = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro" }
  "my-frontend"       = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro" }
  "my-backend-auth"   = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro" }
  "my-backend-items"  = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro" }
  "my-backend-discount" = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro" }
}

subnets ={
  default = {
    "public_subnet_1" = {
      cidr_block                = "10.0.1.0/24"
      availability_zone         = "eu-west-3a"
      map_public_ip_on_launch   = true
      type                      = "public"
      key                       = "1"
    },
    "private_subnet_1" = {
      cidr_block                = "10.0.2.0/24"
      availability_zone         = "eu-west-3a"
      map_public_ip_on_launch   = false
      type                      = "private"
      key                       = "1"
    },
  }
}