#-------------------------------------
############ VPC Resource ############
#-------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

#----------------------------------------
############ Subnet Resource ############
#----------------------------------------
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone

  tags = {
    Name = "${var.prefix}-subnet"
  }
}

#-----------------------------------------
############ Internet Gateway ############
#-----------------------------------------
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix}-gateway"
  }
}

#---------------------------------------------
############ Route Table Resource ############
#---------------------------------------------
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix}-route_table"
  }
}

#---------------------------------------
############ Route Resource ############
#---------------------------------------
resource "aws_route" "route" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
}

#------------------------------------------------
############ Route Table Association ############
#------------------------------------------------
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

#---------------------------------------
############ Security Group ############
#---------------------------------------
resource "aws_security_group" "sg" {
  name   = "${var.prefix}-security_group"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.local_ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-security_group"
  }
}

#-------------------------------------
############ S3 Bucket Resource ############
#-------------------------------------
module "s3_bucket" {
  source = "modules/S3"

  bucket_name = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

#-------------------------------------
############ EC2 Resource ############
#-------------------------------------
module "ec2_instance" {
  source = "modules/EC2"

  ami_id                 = var.ami
  instance_type          = var.instance_type
  security_group_id      = [aws_security_group.sg.id]
  subnet_id              = var.aws_subnet.subnet.id
  user_data              = file("${path.module}/docker.sh")

  tags = {
    Name = var.instance_name
  }
}