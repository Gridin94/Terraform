#Print vm password:

output "admin_password" {
  sensitive = true
  value = module.vms[*].pass
}
