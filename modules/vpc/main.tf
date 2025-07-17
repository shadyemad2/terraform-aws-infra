resource "aws_vpc" "vpc_app" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = "vpc_app"
}
}