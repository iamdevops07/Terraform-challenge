resource "aws_key_pair" "citadel-key" {
  key_name   = "citadel"
  public_key = file("${path.module}/.ssh/ec2-connect-key.pub")
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "citadel" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data     = file("install-nginx.sh")
  provisioner "local-exec" {
    command = "echo ${self.public_dns} >> /root/citadel_public_dns.txt"
  }
}

resource "aws_eip" "eip" {
  instance = aws_instance.citadel.id
  vpc      = true
}


