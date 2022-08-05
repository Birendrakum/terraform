provider "aws" {
  access_key = "ASIAVKCFJZ7FCZ367C5J"
  secret_key = "UBz6rmY4uJ9SpopUZiaU2kqxe0ws6UA2u4PC76yD"
  token = "FwoGZXIvYXdzEHMaDBKYrz/R0ay8hhR9BiK6AZifqXFi/BfuQqRxJFPqiUKz+NzJOE+y28b0vnJz7eU8a4qY2GugC0VahY5UCUkWsSQ1+e/VXDRBJlZzZO+yiDUJh731qpNchTBErRvv+hwBhDAEd3mCnMPBEp4eCSk5ijpVZB7TeIL5rE1AjMl+18vQ+Ju2mCC+FSotCmeQMGH+GiRSjPq3jPRSEju5Q562KRTdugpifGUGlGiXASlloA1XihM7pjbydezd2VQ6rFyAPJXDeZqS9Pee1Cjw07OXBjItcjRKuIqQ58zZDYkd1dKdfM04PV0WHkVOj48rGEPLwHS5aaIV1c43tUy5puRE"
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
  provisioner "remote-exec"{
    inline = [
      "echo 'build ssh connection' "
      ]
  }
  connection {
    host = self.public_ip
    type = "ssh"
    user = "ec2-user"
    private_key = file(var.SSH_key)
}
 provisioner "local-exec" {
   command = "ansible-playbook -i ${aws_instance.myFirstInstance.public_ip}, --private-key ${var.SSH_key} play.yaml "
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

