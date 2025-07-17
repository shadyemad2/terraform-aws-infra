output "alb_dns_name" {
    description = "dns of the public alb"
    value = aws_lb.public_alb.dns_name
}
output "proxy_target_group_arn" {
    description = "target group arn"
    value = aws_lb_target_group.proxy_target_group.arn
  
}