output "bastion_public_ip" {
  description = "The public IP address of the bastion host"
  value       = aws_instance.bastion_host.public_ip
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}


