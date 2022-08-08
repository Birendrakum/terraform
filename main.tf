provider "aws" {
  access_key = "ASIAVKCFJZ7FKNLLN5MO"
  secret_key = "dmCUcTMbWYtPmfMERE3/870AKfl2vIta/zd2VIgu"
  token = "FwoGZXIvYXdzELr//////////wEaDKruEvADbGIfrCukpCK6AWq+mXNrqnee+0W9E/C46st/Z8wgKNpkcUEFVU8JQ4DqOKKllw1FBJ7+1z6Sn0Wg93HD4HtzT7lYxakbXWFHmwpUImqlZ3m86Uej8Q55n4fhwu1p1W3bqeAyBmSNpDGxq6KKi3RfP8rA3PaBVhsbgiHltynYtL9Ifj2+fRJdoJEOYE3Rswr5yock4moNGJTEFOxVy1aB7SRFsKDiEHd74/7YuWonrUU2bpH8jL6xdbEQgDvQSqRaOWmrICjAncOXBjItGy4IRs8v3NokipVsbBkwTuG0fBp0FEyb1Aj5wVc7xwJxESffxAxSmfxCVIU1"
  region = var.aws_region
}

#Create security group with firewall rules
resource "aws_security_group" "my_security_group" {
  name        = var.security_group
  description = "security group for Ec2 instance"

  #Allow jenkins to connect 
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
#Allow SSH to connect
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
      "echo 'build ssh connection' ", "sudo yum update"
      ]
  connection {
    host = self.public_ip
    type = "ssh"
    user = "ec2_user"
    private_key = file(var.SSH_key)
}
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

