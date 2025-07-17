variable "vpc_id" {
    description = "id of vpc"
    type = string
}

variable "public_subnet_ids" {
    description = "publis subnets ids"
    type = list(string)
}

