##### Adjust these
variable "aws_tag_name" {
  default = "jyarbrough"
}

variable "aws_region" {
  default         = "us-east-1"
}

variable "aws_creds_file" {
  default = "~/.aws/credentials"
}

variable "aws_creds_profile" {
  default = "default"
}
variable "aws_keypair_name" {
  default = "DevOps"
}

variable "aws_pem_file" {
  default = "/Users/jeffery.yarbrough/Documents/Dynatrace/AWS-EKS/DevOps.pem"
}

###### leave these as is
variable "server_instance_type" {
  default         = "t2.medium"
}
variable "server_ami" {
  default         = "ami-04763b3055de4860b"
  description     = "Ubuntu Server 16.04 LTS (HVM), SSD Volume Type (64-bit x86)"
}

variable "aws_vpc_cidr" {
  default = "172.16.10.0/24"
}