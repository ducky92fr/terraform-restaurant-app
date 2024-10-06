variable "cidr_block" {
  description = "CIDR blocks"
  type        = string
}

variable "availability_zone" {
  description = "list of availability zone"
  type        = string
}

variable "type" {
    description = "type of subnet"
    type=string
}

variable "map_public_ip_on_launch" {
    description = "map public ip on launch"
    type=bool
}
variable "key"{
    description = "number of subnet"
    type=string
}
