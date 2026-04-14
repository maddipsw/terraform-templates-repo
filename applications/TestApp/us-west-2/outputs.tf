output "instance_ids" {
  description = "Map of instance IDs"
  value = {
    for key, module in module.ec2_instances :
    key => module.instance_ids
  }
}

output "private_ips" {
  description = "Map of private IPs"
  value = {
    for key, module in module.ec2_instances :
    key => module.private_ips
  }
}

output "availability_zones" {
  description = "Map of availability zones"
  value = {
    for key, module in module.ec2_instances :
    key => module.availability_zones
  }
}

output "computed_names" {
  description = "Map of computed instance names"
  value = {
    for key, module in module.ec2_instances :
    key => module.computed_names
  }
}

output "ebs_volume_ids" {
  description = "Map of EBS volume IDs"
  value = {
    for key, module in module.ec2_instances :
    key => module.ebs_volume_ids
  }
}

output "volume_attachment_ids" {
  description = "Map of volume attachment IDs"
  value = {
    for key, module in module.ec2_instances :
    key => module.volume_attachment_ids
  }
}

output "drift_detection_data" {
  description = "Map of drift detection data"
  value = {
    for key, module in module.ec2_instances :
    key => module.drift_detection_data
  }
  sensitive = true
}

output "stack_info" {
  description = "Summary information about the stack"
  value = {
    region          = var.aws_region
    instance_count  = length(module.ec2_instances)
    instance_names  = [
      for key, module in module.ec2_instances :
      module.computed_names
    ]
  }
}