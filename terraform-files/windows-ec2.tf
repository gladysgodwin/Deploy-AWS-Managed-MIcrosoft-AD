resource "aws_instance" "server1" {
  ami                         = var.ami
  instance_type               = var.ec2-1_type
  subnet_id                   = aws_subnet.AD-vpc1pub-subnet.id
  security_groups             = aws_security_group.vpc1-sg.id
  key_name                    = var.key_name
  associate_public_ip_address = true
  iam_instance-profile        = aws_iam_role.myiam_role.id
  
  tags = {
    "Name" = var.ec2-name
  }
}