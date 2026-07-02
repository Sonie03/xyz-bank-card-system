resource "aws_instance" "devops_server" {

  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = var.instance_type

  key_name = "xyz-bank-key"

  subnet_id = "0f85fe9952de75e8d"

  vpc_security_group_ids = [
    "sg-0b8b3d51890664388"
  ]

  associate_public_ip_address = true

  tags = {
    Name = "xyz-bank-devops-server"
  }
}