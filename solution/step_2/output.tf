output "unique_id" {
  value = random_string.unique_id.id
}

output "webserver" {
  value = "http://${aws_lb.webserver_lb.dns_name}"
}
