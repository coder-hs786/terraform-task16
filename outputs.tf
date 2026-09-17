output "vpc_id" {
  value = aws_vpc.task16_vpc.id
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "private_server_ip" {
  value = aws_instance.private.private_ip
}
