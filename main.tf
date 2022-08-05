provider "aws" {
  access_key = "AKIAVKCFJZ7FKEKJUNMS"
  secret_key = "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"
  region = var.aws_region
}

#Create security group with firewall rules
resource "aws_security_group" "my_security_group" {
  name        = var.security_group
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

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}

# Create AWS ec2 instance
resource "aws_instance" "myFirstInstance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = var.tag_name
  }
  provisioner "remote-access"{
    inline = [
      "echo 'build ssh connection' "
      ]
  }
  connection {
    host = self.public_ip
    type = "ssh"
    user = "ec2_user"
    private_key = var.key_pair
}
 provisioner "local-exec" {
   command = "ansible-playbook -i ${aws_instance.myFirstInstance.public_ip}, --private-key ${var.key_pair} play.yaml "
 }
}

# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  vpc      = true
  instance = aws_instance.myFirstInstance.id
tags= {
    Name = "my_elastic_ip"
  }
}

output "public_dns" {
  value = aws_instance.myFirstInstance.*.public_dns
}

