provider "aws"{
    region = "ap-northeast-2" // 제공자 리전 정보
}

resource "aws_instance" "EC2Test" {
    ami = "ami-0e17ad9abf7e5c818" // Amazon Linux 2 AMI
    instance_type = "t2.micro" // 인스턴스 유형

    tags = {
        Name = "terraform Test" // 태그 이름 추가
    }
}
