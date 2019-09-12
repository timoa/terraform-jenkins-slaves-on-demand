output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "ID of the VPC public subnet"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "ID of the VPC private subnet"
  value       = module.vpc.private_subnets
}

output "jenkins_master_sg_id" {
  description = "ID of the Jenkins master security group"
  value       = module.jenkins_master_sg.this_security_group_id
}

output "jenkins_slaves_sg_id" {
  description = "ID of the Jenkins slaves security group"
  value       = module.jenkins_slaves_sg.this_security_group_id
}
