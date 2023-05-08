vpc_1                   = "VPC-AD-MS"
cidr_block_vpc1         = "10.3.0.0/16"
vpc_2                   = "VPC-ONPREM"
cidr_block_vpc2         = "10.102.0.0/16"
region                  = "eu-west-1"
inbound-tcp-ports_sg2   = ["3389", "53", "389", "88", "464", "135", "636","49152 - 65535", "3268 - 3269", "445"]
inbound-udp-ports_sg2   = ["53", "389", "123", "464", "88"]
SG-VPC1                 = "VPC-AD-MS-SG"
SG-VPC2                 = "VPC-ONPREM-SG"
key_name                = "testpeer"
domain                  = "praestohealth.com.ng"
ec2-1_type              = "t3.micro"
ec2-2_type              = "t2_large"
ami                     = "ami-0851400a353c3d2c8"
pubsubnets              = ["10.3.0.0/24", "10.102.0.0/24"]
privsubnets             = ["10.3.1.0/24", "10.102.1.0/24"]
azs                     = ["eu-west-1a", "eu-west-1b"]
ec2-name                = "gladysproject.name.ng-server"