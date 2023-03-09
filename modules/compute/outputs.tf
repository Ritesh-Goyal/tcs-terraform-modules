output "frontend_public_ip" {
  value = module.frontend_instance.public_ip
}

output "backend_server_private_ip" {
  value = module.backend_server.private_ip
}