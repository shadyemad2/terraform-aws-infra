
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


resource "aws_instance" "backend_ec2" {
  count = length(var.private_subnet_ids)
  ami = data.aws_ami.amz_ami.id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [var.security_group_id]
  key_name = var.key_name

  tags = {
    Name = "backend-ec2-${count.index + 1}"
  }

  provisioner "file" {
    source      = "backend-app/app.py"
    destination = "/home/ec2-user/app.py"   
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      bastion_host = var.bastion_host_ip
      bastion_user = "ec2-user"
      host        = self.private_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "pkill -f app.py || true",                 
      "sudo dnf install python3 -y",
      "sudo dnf install python3-pip -y",
      "pip3 install Flask --user",
      "mkdir -p /home/ec2-user/app",
      "mv /home/ec2-user/app.py /home/ec2-user/app/app.py",
      
      # Create systemd service
      "echo '[Unit]' | sudo tee /etc/systemd/system/backend.service",
      "echo 'Description=Backend Flask App' | sudo tee -a /etc/systemd/system/backend.service",
      "echo 'After=network.target' | sudo tee -a /etc/systemd/system/backend.service",
      "echo '' | sudo tee -a /etc/systemd/system/backend.service",
      "echo '[Service]' | sudo tee -a /etc/systemd/system/backend.service",
      "echo 'User=ec2-user' | sudo tee -a /etc/systemd/system/backend.service",
      "echo 'ExecStart=/usr/bin/python3 /home/ec2-user/app/app.py' | sudo tee -a /etc/systemd/system/backend.service",
      "echo 'Restart=always' | sudo tee -a /etc/systemd/system/backend.service",
      "echo 'Environment=PYTHONUNBUFFERED=1' | sudo tee -a /etc/systemd/system/backend.service",
      "echo '' | sudo tee -a /etc/systemd/system/backend.service",
      "echo '[Install]' | sudo tee -a /etc/systemd/system/backend.service",
      "echo 'WantedBy=multi-user.target' | sudo tee -a /etc/systemd/system/backend.service",

      # Reload and enable service
      "sudo systemctl daemon-reexec",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable backend.service",
      "sudo systemctl start backend.service"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      bastion_host = var.bastion_host_ip
      bastion_user = "ec2-user"
      host        = self.private_ip
    }
  }
}

resource "aws_lb_target_group_attachment" "backend_alb_attachment" {
  count            = length(var.private_subnet_ids)
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.backend_ec2[count.index].id
  port             = 5000
}
