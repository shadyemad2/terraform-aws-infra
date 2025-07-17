variable "vpc_id" {
    description = "id of vpc"
    type = string
}

variable "private_subnets_ids" {
    description = "ids of private subnets"
    type = list(string)
}

variable "alb_id_sg" {
    description = "sg of the internal alb"
    type = string
  
}