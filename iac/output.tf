output "unique_id" {
  value = random_string.unique_id.id
}

output "production_webserver" {
  value = "http://${aws_instance.production_webserver.public_ip}"
}

output "staging_webserver" {
  value = "http://${aws_instance.staging_webserver.public_ip}"
}

output "private_key_pem" {
  value       = tls_private_key.private_key.private_key_pem
  sensitive   = true
  description = "The SSH private key to connect to the staging and production web servers"
}

output "ssh_production" {
  value = "ssh -o IdentitiesOnly=yes -i ~/.ssh/padok_supelec.id_rsa ubuntu@${aws_instance.production_webserver.public_ip}"
}

output "ssh_staging" {
  value = "ssh -o IdentitiesOnly=yes -i ~/.ssh/padok_supelec.id_rsa ubuntu@${aws_instance.staging_webserver.public_ip}"
}
