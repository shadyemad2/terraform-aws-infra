output "proxy_instances_ids" {
    value = aws_instance.proxy_ec2[*].id
}

output "proxy_instances_public_ips" {
    value = aws_instance.proxy_ec2[*].public_ip
  
}