variable "region" {
  type        = string
  description = "my region"
}

variable "key_name" {
  type        = string
  description = "keypair name"
}

variable "SG-VPC1" {
  type        = string
  description = "alb security name"
}

variable "SG-VPC2" {
  type        = string
  description = "alb security name"
}
variable "privsubnet" {
  type        = list(string)
  description = "list of my priv subnets cid for both vpcs"
}

variable "pubsubnets" {
  type        = list(string)
  description = "my public subnets cidr for both vpcs"
}

variable "azs" {
  type        = list(string)
  description = "azs"
}

variable "cidr_block_vpc1" {
  type        = string
  description = "my vpc cidr block"
}

variable "cidr_block_vpc2" {
  type        = string
  description = "my vpc cidr block"
}

variable "vpc_2" {
  type        = string
  description = "my vpc name"
}

variable "vpc_1" {
  type        = string
  description = "my vpc name"
}

variable "inbound_ports_sg1" {
  type        = string
  description = "TCP inbound ports for vpc1 sg"
}
variable "inbound-tcp-ports_sg2" {
  type        = list(number)
  description = "TCP inbound ports for second sg"
}

variable "inbound-udp-ports_sg2" {
  type        = list(number)
  description = "UDP inbound ports for second sg"
}

variable "domain" {
  type        = string
  description = "domain name"
}


variable "ami" {
  type        = string
  description = "windows instance ami"
}

variable "ec2-1_type" {
  type        = string
  description = "instance type"
}

variable "ec2-2_type" {
  type        = string
  description = "instance type"
}


