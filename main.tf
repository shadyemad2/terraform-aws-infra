module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = "10.0.0.0/16"

}

module "public_subnet" {
  source             = "./modules/public_subnets"
  vpc_id             = module.vpc.vpc_id
  public_subnet_cidr = ["10.0.0.0/24", "10.0.1.0/24"]
  azs                = ["us-east-1a", "us-east-1b"]

  subnet_name = "public subnet"
}

module "private_subnet" {
  source              = "./modules/private_subnets"
  vpc_id              = module.vpc.vpc_id
  private_subnet_cidr = ["10.0.2.0/24", "10.0.3.0/24"]
  azs                 = ["us-east-1a", "us-east-1b"]
  subnet_name         = "private subnet"
}

module "internet_gateway" {
  source            = "./modules/internet_gateway"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.public_subnet.public_subnets_ids
}

module "nate_gateway" {
  source              = "./modules/nat_gateway"
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.public_subnet.public_subnets_ids
  private_subnets_ids = module.private_subnet.private_subnets_ids
  internet_gateway_id = module.internet_gateway.internet_gateway_id

}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  bastion_sg_id = module.bastion_host.bastion_sg_id
}

module "public_alb" {
  source            = "./modules/alb_public"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.public_subnet.public_subnets_ids
  alb_sg_id         = module.security_groups.alb_id_sg

}

module "internal_alb" {
  source              = "./modules/alb_internal"
  vpc_id              = module.vpc.vpc_id
  private_subnets_ids = module.private_subnet.private_subnets_ids
  alb_id_sg           = module.security_groups.alb_id_sg
}

module "proxy_instances" {
  source            = "./modules/Ec2_proxy"
  public_subnet_ids = module.public_subnet.public_subnets_ids
  security_group_id = module.security_groups.proxy_id_sg
  instance_type     = "t2.micro"
  key_name          = "shady-key"
  vpc_id            = module.vpc.vpc_id
  internal_alb_dns_name = module.internal_alb.internal_alb_dns
  target_group_arn  = module.public_alb.proxy_target_group_arn
  private_key_path  = "/home/shady/shady-key.pem"
  backend_private_ips = module.backend_instances.private_ips
}

module "backend_instances" {
  source             = "./modules/Ec2_backend"
  private_subnet_ids = module.private_subnet.private_subnets_ids
  security_group_id  = module.security_groups.backend_id_sg
  instance_type      = "t2.micro"
  key_name           = "shady-key"
  target_group_arn   = module.internal_alb.backend_target_group_arn
  vpc_id             = module.vpc.vpc_id
  private_key_path   = "/home/shady/shady-key.pem"
  bastion_host_ip    = module.bastion_host.bastion_public_ip

}

module "bastion_host" {
  source           = "./modules/bastion_host"
  public_subnet_id = module.public_subnet.public_subnets_ids[0]
  key_name         = "shady-key"
  vpc_id           = module.vpc.vpc_id
  
}
