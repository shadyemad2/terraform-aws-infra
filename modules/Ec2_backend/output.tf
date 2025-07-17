output "backend_instances_ids" {
    value = aws_instance.backend_ec2[*].id
}

output "private_ips" {
  value = aws_instance.backend_ec2[*].private_ip
}

