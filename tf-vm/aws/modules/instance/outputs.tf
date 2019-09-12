output "instance_id" {
  description = "EC2 instance ID"
  value       = module.jenkins_master_ec2.id[0]
}

output "instance_public_ip" {
  description = "Public IP assigned to the EC2 instance"
  value       = module.jenkins_master_ec2.public_ip[0]
}

output "instance_public_dns" {
  description = "Public DNS assigned to the EC2 instance"
  value       = module.jenkins_master_ec2.public_dns[0]
}

output "instance_az" {
  description = "Availability Zone where the EC2 instance is running"
  value       = module.jenkins_master_ec2.availability_zone
}
