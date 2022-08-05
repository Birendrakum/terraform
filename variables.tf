variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-2"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     =  "Key_pair"
}

variable "SSH_key" {
  description = " SSH keys to connect to ec2 instance"
  default     =  "-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAjQU87aikBdnhmCbUZ1n2ESN40rxJYleXxuRqN48fBVdvJY8e
7lPJzR7SBFyjZMONwcrgMjWeWaPOJtA1sWm89VOkZiMA8BJbj36ao28SEdmSSSo7
QuPjPHWiJwFOqQueucvDIS2UwsRl6ZAKe1I6RaGxODshPY0JpDZOXCnTMURhGsjL
GzkJmU8GJcJXVP3SRbyCJMJourIXGXmkzcbFFwZJYUQUDsmRA7Fw53EH8Kr5cr9K
8ZYDWTvdjbivliKEhgiYRyl/iC7L4VLSpqkxT5xnzuaRs0Dlup4TSTbFZz84iaQW
BGAH2EVpEwZwTZWpz9u83gfm4QmU30FB78edjwIDAQABAoIBAC4e+nBX6V0oh0m1
2V375Chyy39QqUeKkk8wQTTukBy1HdrQ1jLoIGX/oHxgt+eqtWAeM/j35FQ46KF1
Ezp09KHfuzLUW+goeN2TcIvnNae02s0nDL6xvY32gxPyr4FGFaF6bNUbDT4t8Y7T
1znCCODhIw7a9+IjkHWudS5bV4ES+bLa3gpZ0SDvMOd4YRnVc03rQADYI5xIaq4t
pEbMVN+LDtoAST6dOjX1lV1YFgnGWcudxYK0SSMG4tQVcHZBdksKM6BaSYFkcqDR
VbuEz7uO22pYqIoOB8eMa1N8/UPWTcssIKICiAFxclwBxwrr51ibmWcWcmQrhFfM
v12bCoECgYEAxhvdE7yVUZ4E6CTCZBFVCmGgVPEe/XtqEHXKP6yr0XFkpcZSU16Y
/Vh7jrKzgtSKPTCoJRLRviDYPcv1G3iVGMm793H6Fi4UHXp0NWBrTgbQwsyHfgUE
bolcDqx01EUoFPR3RnrlL7I6TGLRoA2TI9NWkQ9IpcnUZjODWdjqcW8CgYEAtjq0
MQl1jP/ZId2hnNBNEF9ivZNIBVCrxIlDD49QXh02QtNByLo9nAPh7YqZBw7v/JAo
w2awEEtU3QpCOPD6y0102LLP+8jq+mVjlpmBngG/ZxQ8+ql/7N2+3cvuYx0IC/DI
oTfLm2dPXEJGgFzUm9xtpFvHhoYLu1PMugfJReECgYEAroP1KGHEF/Xf1LAtHgG2
rEJ7/te5uQpy0LUyyQzO/t2pD++4rgBzPRopHfeF8wZQEL9AIAiIA7jjROzaqqx6
iy+LCdu5trg4uA8bN7oMTNvsIu4RnY3F7anLEpIRCL0zJeKE/+1a371dZdTXXOsY
Z0LQy1Bvarx1AuL2HrvbKrkCgYBBN8tLjYYbm2l7fFWdyNL73Bd7n510AYYoBbQR
eooZ1LyZt//gNf9cuer+186ivw7WxkVAgZzbiApsPYKr3Fr1rdf2wjA7fZHTYbv9
pxzDjv6Qhqa4Uzdsb4Qi3xyHLlm15Ev5nv1otdWqQDH5OMACtCYtX4eONqU2OuyX
W7gGIQKBgEi4NOW1liXpwew55u3jsKs4kIuAZw4uZAjsKTnbKjRiRAJQ/5k5ofvY
//uftk9VJ+uQB4IRmeblpALAqY3son9742qj+EMTkNVabMTO1GU+n6P46rJ+VAES
YubsiqgpNzRkwkFMKsur0WWXBu6aCHKgL7T2Kxa4rIMIZBYnl9SJ
-----END RSA PRIVATE KEY-----"
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
  default     = "my-ec2-instance"
}

variable "ami_id" {
  description = "AMI for Ubuntu Ec2 instance"
  default     = "ami-002068ed284fb165b"
}
