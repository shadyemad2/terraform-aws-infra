variable "vpc_id" {
    description = "id of the vpc"
    type = string
}

variable "private_subnet_cidr" {
    description = "cidrs of private subnets"
    type = list(string)
    default = [ "10.0.2.0/24", "10.0.3.0/24" ]
}

variable "azs" {
    description = "az of private subnet"
    type = list(string)
    default = ["us-east-1a", "us-east-1b"]

}

variable "subnet_name" {
    description = "name of the subnet"
    type = string
  
}