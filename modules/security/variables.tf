variable "vpc_id" {
  type        = string
  description = "The VPC ID where the security group will be created"
}

variable "name" {
  type        = string
  description = "The name of the security group"
}

variable "ingress_from_port" {
  type        = number
  description = "The start port for ingress rules"
}

variable "ingress_to_port" {
  type        = number
  description = "The end port for ingress rules"
}

variable "protocol" {
  type        = string
  description = "The protocol to allow in the security group"
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "The list of CIDR blocks for ingress"
}

variable "egress_from_port" {
  type        = number
  default     = 0
  description = "The start port for egress rules"
}

variable "egress_to_port" {
  type        = number
  default     = 0
  description = "The end port for egress rules"
}

variable "egress_protocol" {
  type        = string
  default     = "-1"
  description = "The protocol to allow for egress (default: all protocols)"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "The list of CIDR blocks for egress"
}


variable "tagName" {
    description = "Tag name"
  type=string

}