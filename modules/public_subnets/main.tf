resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet_cidr)
    vpc_id = var.vpc_id
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = true
    tags = {
      Name = "${var.subnet_name}-${count.index +1 }"
    }

  
}