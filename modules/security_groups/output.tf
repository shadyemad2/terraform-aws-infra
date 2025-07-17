output "proxy_id_sg" {
    value = aws_security_group.proxy_secutity_group.id
  
}

output "backend_id_sg" {
    value = aws_security_group.backend_secutity_group.id
  
}

output "alb_id_sg" {
    value = aws_security_group.alb_security_group.id
  
}
