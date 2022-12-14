resource "aws_vpc" "amir_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "dev"
  }
  lifecycle {
    prevent_destroy = true
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "mobileye_public_subnet" {
  vpc_id                  = aws_vpc.amir_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    Name = "dev-public"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_subnet" "amir_public_subnet" {
  vpc_id                  = aws_vpc.amir_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    Name = "dev-public"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_internet_gateway" "amir_internet_gateway" {
  vpc_id = aws_vpc.amir_vpc.id

  tags = {
    Name = "dev-igw"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route_table" "mobileye_public_rt" {
  vpc_id = aws_vpc.amir_vpc.id

  tags = {
    Name = "dev-public-rt"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route_table" "amir_public_rt" {
  vpc_id = aws_vpc.amir_vpc.id

  tags = {
    Name = "dev-public-rt"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.amir_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.amir_internet_gateway.id
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route_table_association" "mobileye_public_association" {
  subnet_id      = aws_subnet.mobileye_public_subnet.id
  route_table_id = aws_route_table.mobileye_public_rt.id
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route_table_association" "amir_public_association" {
  subnet_id      = aws_subnet.amir_public_subnet.id
  route_table_id = aws_route_table.amir_public_rt.id
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_security_group" "mobileye_sg" {
  name        = "mobileye_sg"
  description = " dev security group"
  vpc_id      = aws_vpc.amir_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_security_group" "amir_sg" {
  name        = "dev_sg"
  description = " dev security group"
  vpc_id      = aws_vpc.amir_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_key_pair" "amir_auth" {
  key_name   = "amirkey"
  public_key = file("~/.ssh/amirkey.pub")
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_instance" "mobileye_node1" {
  instance_type          = "t2.medium"
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.amir_auth.id
  vpc_security_group_ids = [aws_security_group.amir_sg.id]
  subnet_id              = aws_subnet.amir_public_subnet.id
  user_data              = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "mobileye-node"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_instance" "mobileye_node2" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.amir_auth.id
  vpc_security_group_ids = [aws_security_group.amir_sg.id]
  subnet_id              = aws_subnet.amir_public_subnet.id
  user_data              = file("userdata2.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "mobileye-node2"
  }
}

locals {
  cluster_name = "mobileye-eks-cluster"
}
