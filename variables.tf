variable "instances" {
  type = map(object({
    ami           = string
    instance_type = string
    instance_name= string
  }))
}



variable "subnets" {
  type = map(object({
    cidr_block          = string
    availability_zone   = string
    public_ip_on_launch = bool
    type                = string
    key                 = string
  }))
  
  description = "Map of subnets with details such as CIDR block, availability zone, public IP, type, and key."
}


variable "securities" {
  type = map(object({
    ingress_from_port   = number
    ingress_to_port     = number
    protocol            = string
    ingress_cidr_blocks = list(string)
    egress_from_port    = number
    egress_to_port      = number
    egress_protocol     = string
    egress_cidr_blocks  = list(string)
    tagName             = string
  }))
  
  description = "Map of security groups with ingress and egress rules, protocol, CIDR blocks, and tags."
}