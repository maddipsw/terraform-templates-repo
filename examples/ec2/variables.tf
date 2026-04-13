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

    ebs_block_devices = list(object({
      name_suffix = string
      device_name = string
      volume_type = string
      volume_size = number
      volume_iops = optional(number)
      throughput  = optional(number)
      kms_key_id  = optional(string)
    }))

    tags        = map(string)
    volume_tags = map(string)
  }))
}
