variable "vpc_id" {
    description = "id of the vpc"
    type = string
}

variable "public_subnet_cidr" {
    description = "cidr of public subnet"
    type = list(string)
    default = [ "10.0.0.0/24" ,"10.0.1.0/24" ]
  
}

variable "azs" {
    description = "az of the subnet"
    type = list(string)
    default = ["us-east-1a", "us-east-1b"]

}

variable "subnet_name" {
    description = "name of the subnet"
    type = string
     
}

