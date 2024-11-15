######## Public Keys for Instances #######
resource "aws_key_pair" "az1_proxy_pub_key" {
  key_name   = "az1_proxy_key"
  public_key = local_file.proxy1_pub_key_file.content
}
resource "aws_key_pair" "az2_proxy_pub_key" {
  key_name   = "az2_proxy_key"
  public_key = local_file.proxy2_pub_key_file.content
}

resource "aws_key_pair" "az1_ws_pub_key" {
  key_name   = "az1_ws_key"
  public_key = local_file.ws1_pub_key_file.content
}

resource "aws_key_pair" "az2_ws_pub_key" {
  key_name   = "az2_ws_key"
  public_key = local_file.ws2_pub_key_file.content
}
######## Private Keys for Instances #######
resource "tls_private_key" "az1_proxy_priv_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "tls_private_key" "az2_proxy_priv_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "tls_private_key" "az1_ws_priv_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "tls_private_key" "az2_ws_priv_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
############ create local pub key files ########
resource "local_file" "proxy1_pub_key_file" {
  content  = tls_private_key.az1_proxy_priv_key.public_key_openssh
  filename = "proxy1_pub_key.pem"
}
resource "local_file" "proxy2_pub_key_file" {
  content  = tls_private_key.az2_proxy_priv_key.public_key_openssh
  filename = "proxy2_pub_key.pem"
}
resource "local_file" "ws1_pub_key_file" {
  content  = tls_private_key.az1_ws_priv_key.public_key_openssh
  filename = "ws1_pub_key.pem"
}
resource "local_file" "ws2_pub_key_file" {
  content  = tls_private_key.az2_ws_priv_key.public_key_openssh
  filename = "ws2_pub_key.pem"
}
############ create local priv key files ########
resource "local_file" "proxy1_priv_key_file" {
  content  = tls_private_key.az1_proxy_priv_key.private_key_pem
  filename = "proxy1_priv_key.pem"
}
resource "local_file" "proxy2_priv_key_file" {
  content  = tls_private_key.az2_proxy_priv_key.private_key_pem
  filename = "proxy2_priv_key.pem"
}
resource "local_file" "ws1_priv_key_file" {
  content  = tls_private_key.az1_ws_priv_key.private_key_pem
  filename = "ws1_priv_key.pem"
}
resource "local_file" "ws2_priv_key_file" {
  content  = tls_private_key.az2_ws_priv_key.private_key_pem
  filename = "ws2_priv_key.pem"
}
