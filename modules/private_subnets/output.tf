output "private_subnets_ids" {
    description = "ids of private subnets"
    value = aws_subnet.private_subnet[*].id

}