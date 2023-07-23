provider "aws"{
    region = "ap-northeast-2" // 제공자 리전 정보
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
}

resource "aws_subnet" "terraform-sub2"{
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"

    availability_zone = "ap-northeast-2"
}


resource "aws_instance" "EC2Test" {
    ami = "ami-0e17ad9abf7e5c818" // Amazon Linux 2 AMI
    instance_type = "t2.micro" // 인스턴스 유형

    tags = {
        Name = "terraform Test" // 태그 이름 추가
    }
}
