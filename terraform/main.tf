terraform {
  required_version = "~> 0.14.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  profile = "securitytest"
}

module "securitytest" {
    source = "terraform-aws-modules/ec2-instance/aws"
    version = "3.3.0"

    name = "securitytest"
    
    ami = "ami-0d359437d1756caa8"
    instance_type = "t2.small"
    key_name = aws_key_pair.key.key_name
    vpc_security_group_ids = [ aws_security_group.securitytest.id ]
    associate_public_ip_address = true

}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "foo" {
  content         = tls_private_key.key.private_key_pem
  filename        = "./ec2-ssh-key.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "key" {
  key_name   = "ec2-ssh-key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "aws_security_group" "securitytest" {

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}
