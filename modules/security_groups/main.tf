resource "aws_security_group" "proxy_secutity_group" {
    name = "proxy_security_group"
    description = "proxy_sg"
    vpc_id = var.vpc_id
    tags = {
      Name = "proxy_security_group"
    }
}

resource "aws_vpc_security_group_ingress_rule" "http_proxy_sg" {
    description = "allow http from anywhere_proxy sg"
    security_group_id = aws_security_group.proxy_secutity_group.id
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
  
}

resource "aws_vpc_security_group_ingress_rule" "ssh_proxy_sg" {
    description = "allow ssh from anywhere proxy sg"
    security_group_id = aws_security_group.proxy_secutity_group.id
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
  
}

resource "aws_vpc_security_group_egress_rule" "egress_all_proxy_sg" {
    security_group_id = aws_security_group.proxy_secutity_group.id
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}
#############################################################################
resource "aws_security_group" "backend_secutity_group" {
    name = "backend_security_group"
    description = "backend_sg"
    vpc_id = var.vpc_id
    tags = {
      Name = "backend_security_group"
    }
}


resource "aws_vpc_security_group_ingress_rule" "flask_backend_sg" {
security_group_id            = aws_security_group.backend_secutity_group.id
  description                  = "Allow Flask TCP 5000 from proxy"
  from_port                    = 5000
  to_port                      = 5000
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.proxy_secutity_group.id
  
}
resource "aws_vpc_security_group_ingress_rule" "ssh_backend_sg_from_bastion" {
  description                  = "Allow SSH from bastion"
  security_group_id            = aws_security_group.backend_secutity_group.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
  referenced_security_group_id = var.bastion_sg_id
}


resource "aws_vpc_security_group_egress_rule" "egress_all_backend_sg" {
  security_group_id = aws_security_group.backend_secutity_group.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
######################################################################
resource "aws_security_group" "alb_security_group" {
    name = "alp_security_group"
    description = "allow http to alp"
    vpc_id = var.vpc_id  
    tags = {
      Name = "alb_securiy_group"
    }
}

resource "aws_vpc_security_group_ingress_rule" "http_alb_sg" {
  security_group_id = aws_security_group.alb_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP from anywhere"
}

resource "aws_vpc_security_group_egress_rule" "egress_all_alb_sg" {
  security_group_id = aws_security_group.alb_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"
}
########################################################

