data "aws_ami" "amz-ami" {
  most_recent = true
  owners      = ["amazon"]
   filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
   filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

resource "aws_instance" "bastion_host" {
  ami                         = data.aws_ami.amz-ami.id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "bastion_host"
  }
}
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH access"
  vpc_id      = var.vpc_id
  tags = {
    Name = "bastion_host_security_group"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
