
    # Create VPC
    resource "aws_vpc" "main" {
        cidr_block = "10.0.0.0/16"
        
        tags={
            Name = var.aws_name_vpc
        }
    }

    # Create Public Subnet 
    resource "aws_subnet" "public_1a" {
        vpc_id = aws_vpc.main.id
        cidr_block = "10.0.1.0/24"
        availability_zone = var.public_azs[0]

        map_public_ip_on_launch = true
        
        tags = {
            Name = "public-subnet-ap-1a"
        }
    }

    resource "aws_subnet" "public_1b" {
        vpc_id = aws_vpc.main.id
        cidr_block = "10.0.2.0/24"
        availability_zone = var.public_azs[1]

        map_public_ip_on_launch = true

        tags = {
            Name = "public-subnet-ap-1b"
        }
    }

    # Create Private Subnet
    resource "aws_subnet" "private_1a" {
        vpc_id = aws_vpc.main.id
        cidr_block = "10.0.3.0/24"
        availability_zone = var.private_azs[0]

        map_public_ip_on_launch = false

        tags = {
            Name = "private-subnet-ap-1a"
        }
    }

    resource "aws_subnet" "private_1b" {
        vpc_id = aws_vpc.main.id
        cidr_block = "10.0.4.0/24"
        availability_zone = var.private_azs[1]

        map_public_ip_on_launch = false

        tags = {
            Name = "private-subnet-ap-1b"
        }
    }

    # Create Route tables
    ## Public 
    resource "aws_route_table" "public" {
        vpc_id = aws_vpc.main.id
        tags = {
            Name = "project-rtb-public"
        }
    }

    resource "aws_route_table_association" "public1" {
        subnet_id = aws_subnet.public_1a.id
        route_table_id = aws_route_table.public.id
    }

    resource "aws_route_table_association" "public2" {
        subnet_id = aws_subnet.public_1b.id
        route_table_id = aws_route_table.public.id
    }
    ## Private
    resource "aws_route_table" "private1a" {
        vpc_id = aws_vpc.main.id
        tags = {
            Name = "project-rtb-privat1-ap-southeast-1a"
        }
    }

    resource "aws_route_table" "private1b" {
        vpc_id = aws_vpc.main.id
        tags = {
            Name = "project-rtb-privat1-ap-southeast-1b"
        }
    }

    resource "aws_route_table_association" "private1a" {
        subnet_id = aws_subnet.private_1a.id
        route_table_id = aws_route_table.private1a.id
    }

    resource "aws_route_table_association" "private1b" {
        subnet_id = aws_subnet.private_1b.id
        route_table_id = aws_route_table.private1b.id
    }

    # Create Internet Gate Way

    resource "aws_internet_gateway" "gw" {
        vpc_id = aws_vpc.main.id
        tags = {
            Name = "project-igw"
        }
    }

    #association route table to igw
    resource "aws_route" "public_internet_access" {
        route_table_id = aws_route_table.public.id
        destination_cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }