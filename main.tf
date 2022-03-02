variable "access_key" {
    description = "access key for iam user"
}

variable "secret_key" {
    description = "access key for iam user"
}

variable "region" {
    description = "access key for iam user"
}

provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}

variable "subnet_1_cidr_block" {
    description = "cider block for development subnet 1"
}

variable "vpc_cidr_block" {
    description = "cider block for development vpc"
}

variable "env" {
    description = "different env"
}

resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block 
    tags = {
        Name: var.env
        vpc_env: "dev"
    }
}

resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.subnet_1_cidr_block 
    availability_zone = "ap-south-1a"
    tags = {
        Name: var.env
    }
}

data "aws_vpc" "existing_vpc" {
    default = true
}

resource "aws_subnet" "default-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.48.0/20"
    availability_zone = "ap-south-1a"
    tags = {
        Name: "default-subnet-2"
    }
}

output "dev-vpc-id" {
    value = aws_vpc.vpc.id
}

output "subnet-1-id" {
    value = aws_subnet.subnet-1.id
}