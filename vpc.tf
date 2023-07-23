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

resource "aws_subnet" "terraform-sub2"{
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"

    availability_zone = "ap-northeast-2"

    tags = {
        Name = "terraform_sub1"
    }
}