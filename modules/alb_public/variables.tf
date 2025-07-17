variable "vpc_id" {
    description = "id of vpc"
    type = string
  
}

variable "public_subnet_ids" {
    description = "ids pf public subnets"
    type = list(string)
  
}
 variable "alb_sg_id" {
    description = "id of security group for alp"
    type = string
   
 }