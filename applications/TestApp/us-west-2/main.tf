terraform {
  required_version = ">= 1.13.1"
  backend "s3" {
    bucket       = "terraform-temps"
    key          = "tfstate/TestApp.tfstate"
    region       = var.aws_region
    encrypt      = true
    use_lockfile = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "ec2_instances" {
  for_each = var.servers
  source   = "git::https://github.com/maddipsw/terraform-modules-repo.git//modules/ec2?ref=v1.0.0"

  name_prefix              = each.value.name_prefix
  instance_count           = each.value.instance_count
  starting_instance_number = each.value.starting_instance_number

  ami_id                 = each.value.ami_id
  default_instance_type  = each.value.default_instance_type
  instance_types_by_name = each.value.instance_types_by_name

  subnet_ids             = each.value.subnet_ids
  vpc_security_group_ids = each.value.security_group_ids
  key_name               = var.key_name
  iam_instance_profile   = var.iam_instance_profile

  enable_monitoring             = var.enable_monitoring
  enable_termination_protection = var.enable_termination_protection
  enable_drift_detection        = var.enable_drift_detection

  metadata_options_http_tokens                 = var.metadata_options_http_tokens
  metadata_options_instance_metadata_tags      = var.metadata_options_instance_metadata_tags
  metadata_options_http_put_response_hop_limit = var.metadata_options_http_put_response_hop_limit

  protect_from_destroy = var.protect_from_destroy
  protect_data_volumes = var.protect_data_volumes
  force_detach_volumes = var.force_detach_volumes

  root_volume       = each.value.root_volume
  ebs_block_devices = each.value.ebs_block_devices

  tags = merge(
    var.common_tags,
    each.value.tags
  )

  volume_tags = merge(
    var.common_volume_tags,
    each.value.volume_tags
  )
}