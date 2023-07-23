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

    availability_zone = "ap-northeast-2"

    tags = {
        Name = "terraform_sub1"
    }
}

resource "aws_subnet" "terraform_sub2"{
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"

    availability_zone = "ap-northeast-2"

    tags = {
        Name = "terraform_sub2"
    }
}

resource "aws_internet_gateway" "main_igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "main-igw"
    }
}

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
