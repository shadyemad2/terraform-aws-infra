resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = {
      Name = "eip-nat"
    }
}

resource "aws_nat_gateway" "nat_gatway" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = var.public_subnet_ids[0]
    tags = {
      Name = "Nat_Gateway"
    }
}
resource "aws_route_table" "private_route_table" {
    
    vpc_id = var.vpc_id
    tags = {
      Name = "private_route_table"
    }
}

resource "aws_route" "private_route_nat" {
    route_table_id = aws_route_table.private_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gatway.id
  
}

resource "aws_route_table_association" "private_subnet_associate" {
    count = length(var.private_subnets_ids)
    route_table_id = aws_route_table.private_route_table.id
    subnet_id = var.private_subnets_ids[count.index]
  
}