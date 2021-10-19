output "unique_id" {
  value = random_string.unique_id.id
}

output "webserver" {
  value = "http://${aws_lb.webserver_lb.dns_name}"
}

# output "private_key_pem" {
#   value       = tls_private_key.private_key.private_key_pem
#   sensitive   = true
#   description = "The SSH private key to connect to the staging and production web servers"
# }

# output "ssh" {
#   value = "ssh -o IdentitiesOnly=yes -i ~/.ssh/padok_supelec.id_rsa ubuntu@${aws_instance.webserver.public_ip}"
# }

