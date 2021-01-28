output "instance_id" {
  value = aws_instance.this.id
}

output "Public_DNS" {
  value = aws_instance.this.public_dns
}

output "Instance_Public_IP" {
  value = aws_instance.this.public_ip
}

output "Administrator_Password" {
  value = rsadecrypt(aws_instance.this.password_data, file("/mnt/c/Projects/jerome-key.pem"))
}

output "SSH_Key_Name" {
  value = var.key_name
}

# output "Key_Filename-Private" {
#   value = var.key_name.private_key_filename
# }


# output "Key_Filename-Public" {
#   value = module.ssh_key_pair.public_key_filename
# }
