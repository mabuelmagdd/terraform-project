variable "vpc_cidr_block" {
  type = string
}
variable "az1" {
  type = string
}
variable "az2" {
  type = string
}
variable "az1_pub_subnet_cidr_block" {
  type = string
}
variable "az1_priv_subnet_cidr_block" {
  type = string
}
variable "az2_pub_subnet_cidr_block" {
  type = string
}
variable "az2_priv_subnet_cidr_block" {
  type = string
}
variable "ami_data_source" {
  type = string
}
variable "ssh_cidr_block" {
  description = "CIDR Block for SSH"
  type        = string
}
variable "instance_type" {
  type = string
}
variable "ami_id" {
  type = string
}

