provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "bucket-4-tfstate-12345"
    key = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

# Create a bucket
resource "aws_s3_bucket" "new_bucket" {
  bucket = "automate-iac-bucket-123123123"
}

# Create a KeyPair
resource "aws_key_pair" "new_keypair" {
  key_name = "automate-iac-kp"
  public_key = "${var.public_key}"

  tags = {
    Name = "automate-iac"
  }
}

# AMI lookup
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Create VPC
resource "aws_vpc" "automate-iac-vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "automate-iac"
  }
}

# Create subnet
resource "aws_subnet" "automate-iac-subnet" {
  vpc_id = aws_vpc.automate-iac-vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "automate-iac"
  }
}

# Create network interface
resource "aws_network_interface" "automate-iac-aws_network_interface" {
  subnet_id = aws_subnet.automate-iac-subnet.id

  tags = {
    Name = "automate-iac"
  }
}

# Create EC2 instance with created key pair
resource "aws_instance" "new_instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "automate-iac-kp"

  network_interface {
    network_interface_id = aws_network_interface.automate-iac-aws_network_interface.id
    device_index = 0
  }

  tags = {
    Name = "automate-iac"
  }
}