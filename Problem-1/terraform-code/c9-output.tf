output "amzlinux" {
  description = "AMI ID"
  value       = data.aws_ami.amz_linux2.id
}

output "instance_public_ip" {
  value = aws_instance.myec2_webserver.*.public_ip
}

output "rds_address" {
  value = aws_db_instance.rds_instace.address
}
