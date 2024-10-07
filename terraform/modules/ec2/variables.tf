variable "instance_name" {
   description = "Name of EC2 instance"
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_id" {
  description = "Id of subnet"
  type        = string
}

variable "key_name" {
    description = "key name"
  type        = string
}