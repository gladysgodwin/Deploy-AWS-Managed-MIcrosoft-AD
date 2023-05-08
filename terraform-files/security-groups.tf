resource "aws_security_group" "vpc1-sg" {
  name        = "vpc1-sg"
  description = "Allow inbound traffic to instance"
  vpc_id      = aws_vpc.AD-vpc1.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "All"
    cidr_blocks = var.cidr_block_vpc1
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = var.SG-VPC1
  }

}

resource "aws_security_group" "vpc2-sg" {
  name        = "vpc2-sg"
  description = "Allow inbound traffic to instance"
  vpc_id      = aws_vpc.AD-vpc2.id

  dynamic "ingress" {
    for_each = var.inbound-tcp-ports_sg2
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.cidr_block_vpc1
    }
  }

  dynamic "ingress" {
    for_each = var.inbound-udp-ports_sg2
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.cidr_block_vpc1
    }
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "All"
    cidr_blocks = var.cidr_block_vpc2
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = var.SG-VPC2
  }

}


