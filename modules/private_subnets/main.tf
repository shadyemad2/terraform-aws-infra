resource "aws_subnet" "private_subnet" {
    count = length(var.private_subnet_cidr)
    vpc_id = var.vpc_id
    cidr_block = var.private_subnet_cidr[count.index]
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = false
    tags = {
      Name = "${var.subnet_name}-${count.index +1}"
    }
  
}