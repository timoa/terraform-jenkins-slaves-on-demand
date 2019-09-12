output "jenkins_master_public_ip" {
  description = "Public IP assigned to the Jenkins master"
  value       = module.instance.instance_public_ip
}

output "jenkins_master_public_dns" {
  description = "Public DNS assigned to the Jenkins master"
  value       = module.instance.instance_public_dns
}

# output "jenkins_master_efs_id" {
#   description = "EFS volume ID used by the Jenkins master"
#   value       = module.network.efs_id
# }

