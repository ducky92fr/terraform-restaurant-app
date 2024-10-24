instances = {
  "my-haproxy"        = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro",instance_name:"my-haproxy",subnet:"public_subnet_1",key_name:"generalUseRestaurant",associate_public_ip_address:true }
  "my-frontend"       = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro",instance_name:"my-frontend",subnet:"public_subnet_1",key_name:"generalUseRestaurant",associate_public_ip_address:true  }
  "my-backend-auth"   = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro",instance_name:"my-backend-auth",subnet:"private_subnet_1",key_name:"generalUseRestaurant",associate_public_ip_address:false }
  "my-backend-items"  = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro",instance_name:"my-backend-items",subnet:"private_subnet_1",key_name:"generalUseRestaurant",associate_public_ip_address:false }
  "my-backend-discount" = { ami = "ami-045a8ab02aadf4f88", instance_type = "t2.micro",instance_name:"my-backend-discount",subnet:"private_subnet_1",key_name:"generalUseRestaurant",associate_public_ip_address:false }
}

subnets = {
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
"public_subnet_2" = {
      cidr_block                = "10.0.3.0/24"
      availability_zone         = "eu-west-3b"
      public_ip_on_launch   = true
      type                      = "public"
      key                       = "1"
    },
    "private_subnet_2" = {
      cidr_block                = "10.0.4.0/24"
      availability_zone         = "eu-west-3b"
      public_ip_on_launch   = false
      type                      = "private"
      key                       = "1"
    },
  
}

securities ={
  "http"={
    ingress_from_port: 80
    ingress_to_port:80
    protocol: "tcp"
    ingress_cidr_blocks:["0.0.0.0/0"]
    egress_from_port:0
    egress_to_port:0
    egress_protocol:"-1"
    egress_cidr_blocks:["0.0.0.0/0"]
    tagName:"allow-http-sg"
  }
  "ssh"={
    ingress_from_port: 22
    ingress_to_port:22
    protocol: "tcp"
    ingress_cidr_blocks:["0.0.0.0/0"]
    egress_from_port:0
    egress_to_port:0
    egress_protocol:"-1"
    egress_cidr_blocks:["0.0.0.0/0"]
    tagName:"allow-ssh-sg"
  }
}
