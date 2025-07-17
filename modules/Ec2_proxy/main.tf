data "aws_ami" "amz_ami" {
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

resource "aws_instance" "proxy_ec2" {
  count                  = length(var.public_subnet_ids)
  ami                    = data.aws_ami.amz_ami.id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[count.index]
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install -y nginx",
      "echo '${data.template_file.nginx_config.rendered}' | sudo tee /etc/nginx/nginx.conf",
      "sudo systemctl enable nginx",
      "sudo systemctl restart nginx"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "echo public ip of proxy-ec2-${count.index + 1} >> ips_proxy_ec2.txt && echo ${self.public_ip} >> ips_proxy_ec2.txt"
  }

  tags = {
    Name = "proxy-ec2-${count.index + 1}"
  }
}

resource "aws_lb_target_group_attachment" "proxy_alb_attachment" {
  count            = length(var.public_subnet_ids)
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.proxy_ec2[count.index].id
  port             = 80
}

data "template_file" "nginx_config" {
  template = file("${path.module}/nginx.conf.tpl")

  vars = {
    backend1 = var.backend_private_ips[0]
    backend2 = var.backend_private_ips[1]
  }
}