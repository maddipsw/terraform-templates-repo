variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "servers" {
  type = map(object({
    name_prefix              = string
    ami_id                   = string
    instance_count           = optional(number, 1)
    starting_instance_number = optional(number, 1)
    default_instance_type    = string
    instance_types_by_name   = optional(map(string), {})
    subnet_ids               = list(string)
    vpc_security_group_ids   = list(string)

    root_volume = object({
      volume_type = string
      volume_size = number
      volume_iops = optional(number)
      throughput  = optional(number)
      kms_key_id  = optional(string)
    })

    ebs_block_devices = optional(list(object({
      name_suffix = string
      device_name = string
      volume_type = string
      volume_size = number
      volume_iops = optional(number)
      throughput  = optional(number)
      kms_key_id  = optional(string)
    })), [])

    ebs_block_devices_by_instance = optional(map(list(object({
      name_suffix = string
      device_name = string
      volume_type = string
      volume_size = number
      volume_iops = optional(number)
      throughput  = optional(number)
      kms_key_id  = optional(string)
    }))), {})

    tags        = optional(map(string), {})
    volume_tags = optional(map(string), {})
  }))
}

variable "key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "IAM instance profile to attach to instances"
  type        = string
  default     = null
}

variable "enable_monitoring" {
  description = "Enable detailed monitoring for EC2 instances"
  type        = bool
  default     = false
}

variable "enable_termination_protection" {
  description = "Enable termination protection for EC2 instances"
  type        = bool
  default     = false
}

variable "enable_drift_detection" {
  description = "Enable drift detection for EC2 instances"
  type        = bool
  default     = false
}

variable "metadata_options_http_tokens" {
  description = "Whether or not the metadata service requires session tokens (IMDSv2)"
  type        = string
  default     = "required"
}

variable "metadata_options_instance_metadata_tags" {
  description = "Enable instance metadata tags"
  type        = string
  default     = "enabled"
}

variable "metadata_options_http_put_response_hop_limit" {
  description = "The desired HTTP PUT response hop limit for instance metadata requests"
  type        = number
  default     = 1
}

variable "protect_from_destroy" {
  description = "Enable lifecycle prevent_destroy for instances"
  type        = bool
  default     = false
}

variable "protect_data_volumes" {
  description = "Enable lifecycle prevent_destroy for data volumes"
  type        = bool
  default     = false
}

variable "force_detach_volumes" {
  description = "Force detach volumes on instance termination"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "common_volume_tags" {
  description = "Common tags to apply to all volumes"
  type        = map(string)
  default     = {}
}
