######## Data Source for EC2 #######
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]

}
####### Instances #######
resource "aws_instance" "az1_proxy" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.az1_proxy_pub_key.key_name
  subnet_id = aws_subnet.AZ1_pub_subnet.id
  associate_public_ip_address = true
  depends_on = [aws_lb.lb_2]
  vpc_security_group_ids = [aws_security_group.az1_proxy_sg.id]
  tags = {
    Name = "Proxy1"
  }

  provisioner "remote-exec" {
  inline = [
    "sleep 50",
    "sudo apt update -y",
    "sudo apt install nginx -y",
    "sudo systemctl enable nginx",
    "sudo systemctl start nginx",
    "sudo bash -c 'cat > /etc/nginx/sites-enabled/default <<EOL\nserver {\n    listen 80 default_server;\n    location / {\n        proxy_pass http://${aws_lb.lb_2.dns_name};\n    }\n}\nEOL'",
    "sudo systemctl reload nginx"
  ]
}
  connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = tls_private_key.az1_proxy_priv_key.private_key_pem
      host     = self.public_ip
      }

  provisioner "local-exec" {
    command = "echo '${self.public_ip}' >> all_ips.txt && echo '${tls_private_key.az1_proxy_priv_key.private_key_pem}' > az2_ws_priv_key.pem "
}
}

resource "aws_instance" "az2_proxy" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.az2_proxy_pub_key.key_name
  subnet_id = aws_subnet.AZ2_pub_subnet.id
  associate_public_ip_address = true
  depends_on = [aws_lb.lb_2]
  vpc_security_group_ids = [aws_security_group.az2_proxy_sg.id]
  tags = {
    Name = "Proxy2"
  }
    provisioner "remote-exec" {
    inline = [
    "sleep 50",
    "sudo apt update -y",
    "sudo apt install nginx -y",
    "sudo systemctl enable nginx",
    "sudo systemctl start nginx",
    "sudo bash -c 'cat > /etc/nginx/sites-enabled/default <<EOL\nserver {\n    listen 80 default_server;\n    location / {\n        proxy_pass http://${aws_lb.lb_2.dns_name};\n    }\n}\nEOL'",
    "sudo systemctl reload nginx"
  ]
}
  connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = tls_private_key.az2_proxy_priv_key.private_key_pem
      host     = self.public_ip
      }

  provisioner "local-exec" {
    command = "echo '${self.public_ip}' >> all_ips.txt && echo '${tls_private_key.az2_proxy_priv_key.private_key_pem}' > az2_proxy_priv_key.pem"
}
}

resource "aws_instance" "az1_ws" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.az1_ws_pub_key.key_name
  subnet_id = aws_subnet.AZ1_priv_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.az1_ws_sg.id]
  tags = {
    Name = "AZ1 WS Instance"
  }
    provisioner "remote-exec" {
      inline=[
        "sleep 50",
        "sudo apt update -y",
        "sudo apt install apache2 -y",
        "sudo systemctl enable apache2",  
        "sudo systemctl start apache2",
      ]
  }
  connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = tls_private_key.az1_ws_priv_key.private_key_pem
      host     = self.public_ip
      }

  provisioner "local-exec" {
    command = "echo '${self.public_ip}' >> all_ips.txt && echo '${tls_private_key.az1_ws_priv_key.private_key_pem}' > az1_ws_priv_key.pem"
}
}

resource "aws_instance" "az2_ws" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.az2_ws_pub_key.key_name
  subnet_id = aws_subnet.AZ2_priv_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.az2_ws_sg.id]
  tags = {
    Name = "AZ2 WS Instance"
  }
    provisioner "remote-exec" {
      inline=[
        "sleep 50",
        "sudo apt update -y",
        "sudo apt install apache2 -y",
        "sudo systemctl enable apache2",  
        "sudo systemctl start apache2",
      ]
  }
  connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = tls_private_key.az2_ws_priv_key.private_key_pem
      host     = self.public_ip
      }
  provisioner "local-exec" {
    command = "echo '${self.public_ip}' >> all_ips.txt && echo '${tls_private_key.az2_ws_priv_key.private_key_pem}' > az2_ws_priv_key.pem"
}
}