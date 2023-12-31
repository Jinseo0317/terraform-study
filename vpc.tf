provider "aws"{
    region = "ap-northeast-2" // 제공자 리전 정보
    alias = "vpc"
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "terraform-vpc"
    }
}

resource "aws_subnet" "terraform_sub1"{
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"

    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "terraform_sub1"
    }
}

resource "aws_subnet" "terraform_sub2"{
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"

    availability_zone = "ap-northeast-2b"

    tags = {
        Name = "terraform_sub2"
    }
}

// igw 구성

resource "aws_internet_gateway" "main_igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "main-igw"
    }
}

// Route Table 구성

resource "aws_route_table" "main_route_table"{
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "main-rt"
    }
}

resource "aws_route_table_association" "route_table_association_1"{
    subnet_id = aws_subnet.terraform_sub1.id
    route_table_id = aws_route_table.main_route_table.id
}

resource "aws_route_table_association" "route_table_association_2"{
    subnet_id = aws_subnet.terraform_sub2.id
    route_table_id = aws_route_table.main_route_table.id
}

// Private Subnet 구성

resource "aws_subnet" "terraform_private_sub1"{
    vpc_id = aws_vpc.main.id
    cidr_block = "1.0.3.0/24"

    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "terraform-private-sub1"
    }
}

resource "aws_subnet" "terraform_private_sub2"{
    vpc_id = aws_vpc.main.id
    cidr_block = "1.0.4.0/24"

    availability_zone = "ap-northeast-2b"

    tags = {
        Name = "terraform-private-sub2"
    }
}

// private subnet 연결을 위한 eip 구성

resource "aws_eip" "nat1" {
    vpc = true

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_eip" "nat2" {
    vpc = true

    lifecycle {
        create_before_destroy = true
    }
}

// nat gateway 구성

resource "aws_nat_gateway" "nat_gateway_1"{
    allocation_id = aws_eip.nat1.id

    subnet_id = aws_subnet.terraform_sub1.id

    tags = {
        Name = "nat-gateway-1"
    }
}

resource "aws_nat_gateway" "nat_gateway_2"{
    allocation_id = aws_eip.nat2.id

    subnet_id = aws_subnet.terraform_sub2.id

    tags = {
        Name = "nat-gateway-2"
    }
}