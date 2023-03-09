output "internal_id" {
  value = aws_security_group.default_internal.id
}

output "inbound_id" {
  value = aws_security_group.inbound.id
}

output "ssh_id" {
  value = aws_security_group.ssh.id
}

output "inbound_cidrs" {
  value = split(",", var.env == "prod" ? var.prod_cidrs : var.stage_cidrs)
}
