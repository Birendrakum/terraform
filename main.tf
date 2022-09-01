provider "aws" {
  access_key = "ASIAVKCFJZ7FI3BA52NH"
  secret_key = "6uGDnD9R4EmA67Y733kleC8hiYf0L0PdA9RuYNEs"
  token = "FwoGZXIvYXdzEAAaDAMI6ylcyy6/kzhB5yK6Aby8KUZfF6Rcvg1KYbNKwUttIgDNhU+TjFDk3Wm7BztgvvcpuEaNUfm94v8EOGrwwSMZflQ6Nv/VE9ndEQdcePAwCp+jB9j2U7/HqB6Db6FjzUWrlNKlrXYa0CeQObx8pzaL0Bkk2gmMtAIoSpk/CFooOiexGu/KpM9VEoqOXdu8F/kW/8Ms7QSBfLqFdQ7iZh1OBGlK0q4LM+89kJiBS/+65J3u7HW3V4DxiIsSRi23lRhe8LhwTQqVFSja+8KYBjItDnD9D9ttHuW2A1Cw5ImtD8TtGS1Voew1Y4NqS+mJ55fPZosEtk8rtoakdl3N"
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
resource "aws_key_pair" "key"{
  key_name = "key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDYElXk+ApTCBc5dq4IoOCp0VcL4GQRrGpRnHSNUEyIFigyJMzKOq8y7FngbeBQxCYVzSPFnW8zGOb19INqbqxFB84DGu52DsCH4Iof9UueuEcSQaopdR+ohNiuHbdEfoubA+o+Ccchz3qyb9fN0+Wpnh9jO76XR0CKmjfgSR++InFEHTPG0ToxZyVAzGCROduhpd/GG0LlN8oCu3wy4NdurNK/6mdaPraGMMDkWGpuWzmRle06IA6aXg19QDpvr+XCfyimOup/6ufTwziVAjrWw3bm02iRFGcgVdjL4yP6BSVp9N/7RQjp2CfuEUDv5DRIZZn7bLPmaPYIEc9ODkXl4+Y+XFq1WrV0cgvEu85f9O/ZecUGpooqDbmqwvnu5ggwH3jR9pPFDTWDXuypG9otd8QQVD4JwO9Ihl5/JS/+1/cUt2cy8rTtyt6ZE8Wd9ilNbYrBstDjE7e99HiE/2YbOvY0eG4hJdypneW9/df/TXsvS1fZxuytWk99g1EdWac= birendrakum119g@ip-172-31-90-84"
}

# Create AWS ec2 instance
resource "aws_instance" "myFirstInstance" {
  ami           = var.ami_id
  key_name = "key"
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = var.tag_name
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

