terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}
resource "aws_vpc" "TerraformVPC" {
    cidr_block = "15.15.0.0/16"
    tags = {
      Name = "Terraform-vpc"
    }
}
resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.TerraformVPC.id
  cidr_block = "15.15.1.0/24"
  tags = {
    Name = "TerraformSubnet-1"
  }
  
}
resource "aws_internet_gateway" "TerraformIGW" {
  vpc_id = aws_vpc.TerraformVPC.id
  tags = {
    Name = "TIGW"
  }
  
}
resource "aws_route_table" "MRT" {
  vpc_id = aws_vpc.TerraformVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.TerraformIGW.id
  }
  tags = {
    Name = "MRT-Terraform"
  }
}
resource "aws_route_table_association" "PubAssociat" {
  subnet_id = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.MRT.id
  
}

resource "aws_instance" "Terraform_EC2" {
  ami = "ami-0ded8326293d3201b"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet-1.id
  vpc_security_group_ids = ["sg-0f22d4a2dad96ea2c"]
  associate_public_ip_address = "true"
  key_name = "Ethans"
  tags = {
    Name = "TerraformEC2"
  }
  
}