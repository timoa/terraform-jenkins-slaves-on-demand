output "efs_id" {
  description = "ID of the EFS volume"
  value       = "${module.efs.id}"
}

output "efs_host" {
  description = "Host name of the EFS volume"
  value       = "${module.efs.host}"
}

output "efs_mount_target_ids" {
  description = "Mount target IDS of the EFS volume"
  value       = "${module.efs.mount_target_ids}"
}

output "efs_mount_target_ips" {
  description = "Mount target IPs of the EFS volume"
  value       = "${module.efs.mount_target_ips}"
}
