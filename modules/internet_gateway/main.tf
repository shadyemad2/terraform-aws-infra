resource "aws_internet_gateway" "igw_shady" {
    vpc_id = var.vpc_id
    tags = {
      Name = "iqw_app"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = var.vpc_id
    tags = {
      Name = "Public_route_table"
    }
}

resource "aws_route" "public_route" {
    route_table_id = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_shady.id
}

resource "aws_route_table_association" "public_subnet_associate" {
    count = length(var.public_subnet_ids)
    subnet_id = var.public_subnet_ids[count.index]
    route_table_id = aws_route_table.public_route_table.id
    
}