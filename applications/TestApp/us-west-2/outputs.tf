output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = module.ec2.instance_ids
}

output "private_ips" {
  description = "List of private IP addresses of the EC2 instances"
  value       = module.ec2.private_ips
}

output "availability_zones" {
  description = "List of availability zones where instances are deployed"
  value       = module.ec2.availability_zones
}

output "computed_names" {
  description = "List of computed instance names (name_prefix + zero-padded numbers)"
  value       = module.ec2.computed_names
}

output "ebs_volume_ids" {
  description = "List of additional EBS volume IDs"
  value       = module.ec2.ebs_volume_ids
}

output "volume_attachment_ids" {
  description = "List of EBS volume attachment IDs"
  value       = module.ec2.volume_attachment_ids
}

output "drift_detection_data" {
  description = "Drift detection data for monitoring (only available when enable_drift_detection = true)"
  value       = module.ec2.drift_detection_data
  sensitive   = false
}

# Stack specific outputs
output "stack_info" {
  description = "Stack deployment information"
  value = {
    stack_name      = "infprd-amiv1-02"
    region          = var.aws_region
    instance_count  = var.instance_count
    instance_names  = module.ec2.computed_names
    deployment_time = timestamp()
  }
}