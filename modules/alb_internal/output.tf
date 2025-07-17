output "internal_alb_dns" {
    description = "dns of the internal alb"
    value = aws_alb.private_alb.dns_name
}

output "backend_target_group_arn" {
    description = "arn of backend target group"
    value = aws_lb_target_group.backend_target_group.arn
}