output "jenkins_master_public_ip" {
  description = "Public IP assigned to the Jenkins master"
  value       = "${module.instances.instance_public_ip}"
}

output "jenkins_master_public_dns" {
  description = "Public DNS assigned to the Jenkins master"
  value       = "${module.instances.instance_public_dns}"
}