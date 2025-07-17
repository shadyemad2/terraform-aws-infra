variable "vpc_id" {
    description = "id of vpc"
    type = string
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "private_subnet_ids" {
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
  description = "/home/shady.shady-key.pem"
}


variable "target_group_arn" {
  type = string
}

variable "bastion_host_ip" {
  description = "The public IP of the Bastion Host"
  type        = string
}
