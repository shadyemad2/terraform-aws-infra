variable "vpc_id" {
    description = "id of vpc"
    type = string
  
}

variable "public_subnet_ids" {
    description = "the id of the public subnet to place the nat gateway in"
    type = list(string)
  
}

variable "private_subnets_ids" {
    description = "ids of private subnets"
    type = list(string)
  
}
variable "internet_gateway_id" {
    description = "id of internet gateway"
    type = string
  
}