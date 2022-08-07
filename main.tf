provider "aws" {
  access_key = "ASIAVKCFJZ7FBD3BI442"
  secret_key = "gm43vn5JNpQzKegANgmervsj3gND6QLG+hvPaFHN"
  token = "FwoGZXIvYXdzEJ7//////////wEaDMqrNNBUnebSmBpmMSK6AcXx2362hT8VIBwe4knxA9JVtCj8mUmmnmfFYeCvGL0B216UZ1AtoSTXk5+nUPi+opFQz9b07YacHQbNiHhaIdlf2c7e3NNMsYO89y12U3B1J58qLdMOHmGEub9QPIOAbygCFGJZ7CvDBb5DaXoUmdecMzdR9a22io/IHkgDXH5hkr0+LS/nQ3dYgNdOz3RkCuHVcyi7chXSeQMDS1vYqaeXRBsueCf5sKQnbYii+h9lUbNBkm3epRQyoij2gr2XBjItgx6Wjzj7CIvs/gYH/aBRVKHOwmWRwO582sP3h1Qu+nkctmybt2FGwxn2oqQx"
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
      "echo 'build ssh connection' "
      ]
  }
  connection {
    host = "${self.public_ip}"
    type = "ssh"
    user = "root"
    private_key = "file(var.SSH_key)"
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

