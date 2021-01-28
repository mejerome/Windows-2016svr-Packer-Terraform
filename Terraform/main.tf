provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = "172.16.0.0/16"
  tags       = var.tags
}

# Subnet
resource "aws_subnet" "main_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "172.16.10.0/24"
  map_public_ip_on_launch = true

  tags = var.tags
}

# Network interface
resource "aws_network_interface" "main_ni" {
  subnet_id = aws_subnet.main_subnet.id
  tags = var.tags
}

# Security group
resource "aws_security_group" "main_sg" {
  name        = "allow RDP"
  description = "Allow RDP"
  vpc_id      = aws_vpc.main.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow RDP port"
    from_port   = 3389
    protocol    = "tcp"
    to_port     = 3389
  }

  tags = var.tags
}

#-- Grab the latest AMI built with packer - widows2016.json
data "aws_ami" "Windows_2016" {
  filter {
    name   = "is-public"
    values = ["false"]

  }

  filter {
    name   = "name"
    values = ["windows2016Server*"]
  }
  owners      = ["self"]
  most_recent = true
}

#-- sets the user data script
data "template_file" "user_data" {
  template = "./scripts/user_data.ps1"
}


#---- Test Development Server
resource "aws_instance" "this" {
  ami                  = data.aws_ami.Windows_2016.image_id
  instance_type        = var.instance
  key_name             = var.key_name
  subnet_id            = aws_subnet.main_subnet.id
  security_groups      = [aws_security_group.main_sg.id]
  # user_data            = data.template_file.user_data.rendered
  get_password_data    = "true"

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = "true"
  }

  tags = {
    Name = "ehi_windows2016"
    Role = "Dev"
  }
}
