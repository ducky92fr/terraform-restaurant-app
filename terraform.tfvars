instances = {
  "my-haproxy"        = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro",instance_name:"my-haproxy" }
  "my-frontend"       = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro",instance_name:"my-frontend" }
  "my-backend-auth"   = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro",instance_name:"my-backend-auth" }
  "my-backend-items"  = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro",instance_name:"my-backend-items" }
  "my-backend-discount" = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro",instance_name:"my-backend-discount" }
}

subnets ={
    "public_subnet_1" = {
      cidr_block                = "10.0.1.0/24"
      availability_zone         = "eu-west-3a"
      public_ip_on_launch   = true
      type                      = "public"
      key                       = "1"
    },
    "private_subnet_1" = {
      cidr_block                = "10.0.2.0/24"
      availability_zone         = "eu-west-3a"
      public_ip_on_launch   = false
      type                      = "private"
      key                       = "1"
    },
  
}