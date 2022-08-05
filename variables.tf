variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-2"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     =  "key_pair"
}

variable "SSH_key" {
  type = string
  default  = "/home/birendrakum119g/key_pair.pem"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     =  "t2.micro"
}

variable "security_group" {
  description = "Name of security group"
  default     = "my-jenkins-security-group"
}

variable "tag_name" {
  description = "Tag Name of for Ec2 instance"
  default     = "Linux_Instance"
}

variable "ami_id" {
  description = "AMI for Ubuntu Ec2 instance"
  default     = "ami-002068ed284fb165b"
}
