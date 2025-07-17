output "vpc_id" {
  value = module.vpc.vpc_id
  
}

output "proxy_instances_public_ips" {
  value = module.proxy_instances.proxy_instances_public_ips
  
}
 output "backend_instances_private_ips" {
  value = module.backend_instances.private_ips
   
 }

 output "bation_host_public-ip" {
  value = module.bastion_host.bastion_public_ip
   
 }

 output "public_alb_dns_name" {
  value = module.public_alb.alb_dns_name
   
 }