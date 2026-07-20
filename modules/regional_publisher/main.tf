# -----------------------------------------------------------------------------
# Netskope Regional Publisher Infrastructure Module
# -----------------------------------------------------------------------------

# 1. AWS AMI Data Source (Discovers latest Ubuntu 22.04 LTS if no explicit AMI ID provided)
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  selected_publisher_ami = var.publisher_ami_id != "" ? var.publisher_ami_id : data.aws_ami.ubuntu.id
}

# 2. VPC & Networking Components
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = "${var.site_id}-vpc"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.site_id}-igw"
  })
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.site_id}-public-subnet"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(var.tags, {
    Name = "${var.site_id}-public-rt"
  })
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# 3. Security Groups
resource "aws_security_group" "publisher_sg" {
  name        = "${var.site_id}-publisher-sg"
  description = "Security Group for Netskope Publishers"
  vpc_id      = aws_vpc.this.id

  # Inbound Management SSH
  ingress {
    description = "SSH Management Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound Internal VPC Inter-Connectivity
  ingress {
    description = "Self Internal Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # Outbound Rule 1: DNS (53)
  egress {
    description = "Outbound DNS"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rule 2: Netskope Cloud Gateways (HTTPS 443)
  egress {
    description = "Outbound Netskope Cloud Tunnel"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rule 3: Internal Application Traffic Egress
  egress {
    description = "Full Outbound Application Egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.site_id}-publisher-sg"
  })
}

# 4. Netskope Publisher EC2 Instances (HA Pair supported)
resource "aws_instance" "publisher" {
  count                  = var.publisher_count
  ami                    = local.selected_publisher_ami
  instance_type          = var.publisher_instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.publisher_sg.id]
  key_name               = var.key_name

  user_data = templatefile("${path.module}/templates/publisher_user_data.sh.tftpl", {
    registration_token = var.registration_token
  })

  tags = merge(var.tags, {
    Name = "${var.site_id}-publisher-0${count.index + 1}"
    Role = "Netskope-Publisher"
    HA   = var.publisher_count > 1 ? "Pair" : "Single"
  })
}
