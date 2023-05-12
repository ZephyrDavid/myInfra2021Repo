provider "aws" {
  region = var.us-east-1
}

resource "aws_vpc" "main" {
  cidr_block = "172.16.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "main"
  }
}

#Create security group with firewall rules
resource "aws_security_group" "jenkins-sg-2022" {
  name        = var.sg-0e12f567e1eaf87f7
  description = "security group for Ec2 instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkins server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.sg-0e12f567e1eaf87f7
  }
}

resource "aws_instance" "myFirstInstance" {
  ami           = var.ami-007855ac798b5175e
  key_name = var.myJenkinsKey
  instance_type = var.t2.small
  vpc_security_group_ids = [sg-0e12f567e1eaf87f7.jenkins-sg-2022.id]
  tags= {
    Name = var.tag_name
  }
}

# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  vpc      = true
  instance = t2.small.myFirstInstance.id
tags= {
    Name = "my_elastic_ip"
  }
}
