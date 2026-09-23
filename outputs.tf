output "vm_name" {
  description = "Name of the VM"
  value       = google_compute_instance.server.name
}

output "vm_zone" {
  description = "VM zone"
  value       = google_compute_instance.server.zone
}

output "vm_internal_ip" {
  description = "Internal IP address"
  value       = google_compute_instance.server.network_interface[0].network_ip
}

output "vm_external_ip" {
  description = "External IP address"
  value       = google_compute_instance.server.network_interface[0].access_config[0].nat_ip
}

output "data_disk_name" {
  description = "500 GB data disk"
  value       = google_compute_disk.data_disk.name
}
