variable "vpc_id" {
    description = "id of vpc"
    type = string
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "security_group_id" {
    type = string
}

variable "key_name" {
    type = string
    default = "shady-key"
  
}
variable "private_key_path" {
  type = string
  default= "/home/shady.shady-key.pem"
}


variable "target_group_arn" {
  type = string
}

variable "internal_alb_dns_name" {
  description = "The DNS name of the internal ALB"
  type        = string
}

variable "backend_private_ips" {
  type = list(string)
  
}