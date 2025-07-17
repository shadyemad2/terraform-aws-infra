variable "vpc_id" {
    description = "id of vpc"
    type = string
}
variable "bastion_sg_id" {
  description = "Security group ID of bastion host to allow SSH from"
  type        = string
}
