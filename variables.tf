variable "instances" {
  type = map(object({
    ami           = string
    instance_type = string
    instance_name= string
  }))
}



variable "subnets"{
  type = any
}