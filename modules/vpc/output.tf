output "vpc_id" {
    description = "the id of the vpc"
    value = aws_vpc.vpc_app.id
}