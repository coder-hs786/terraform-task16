resource "aws_key_pair" "task16_key" {
  key_name   = "task16-key"
  public_key = file("~/.ssh/task16-key.pub")
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_1.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.task16_key.key_name

  vpc_security_group_ids = [
    aws_security_group.bastion_sg.id
  ]

  tags = {
    Name = "task16-bastion"
  }
}

resource "aws_instance" "private" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.private_1.id
  associate_public_ip_address = false
  key_name                    = aws_key_pair.task16_key.key_name

  vpc_security_group_ids = [
    aws_security_group.private_sg.id
  ]

  tags = {
    Name = "task16-private-server"
  }
}
