variable "public_subnet_id" {
  description = "The public subnet where the bastion host will be created"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use for SSH"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for associating security group"
  type        = string
}
