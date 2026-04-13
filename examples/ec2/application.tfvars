aws_region            = "us-east-2"
key_name              = "terraform_key"
iam_instance_profile  = "EC2InstanceRole"

enable_monitoring             = true
enable_drift_detection        = true
enable_termination_protection = true
protect_from_destroy          = true
protect_data_volumes          = true
force_detach_volumes          = false

# Tags applied to all resources
common_tags = {
      "fv:data-classification"  = "PHI"
      "fv:cmdb-app-id"          = "App-ID"
      "fv:cmdb-number"          = "SNSVC0000000"
      "fv:business-criticality" = "4"
      "map-migrated"            = "abcdefghi"
      "fv:environment"          = "Build"
      "fv:aws-account-id"       = "1234567890"
      "fv:app-supp-group"       = "Application Support and Solutions (ASST)"
      "fv:it-cost-center"       = "10000-7000-1000"
      "fv:department"           = "Application Support and Solutions (ASST)"
      "fv:app-name"             = "App-Name"
      "fv:it-app-owner"         = "App Owner"
      "fv:resource-type"        = "EC2 Instance"
}

common_volume_tags = {
  "fv:resource-type" = "EBS Volume"
}

servers = {
  app = {
    name_prefix              = "CBXAPP"
    ami_id                   = "ami-0123456789abcdef0"
    instance_count           = 3
    starting_instance_number = 1
    default_instance_type    = "t3.large"
    instance_types_by_name = {
      CBXAPP002 = "t3.xlarge"
      CBXAPP003 = "m6i.large"
    }

    subnet_ids               = ["subnet-aaaaaaaa", "subnet-bbbbbbbb"]
    vpc_security_group_ids   = ["sg-aaaaaaaa"]

    root_volume = {
      volume_type = "gp3"
      volume_size = 80
      volume_iops = 3000
      throughput  = 125
    }

    ebs_block_devices = [
      {
        name_suffix = "appdata"
        device_name = "/dev/sdf"
        volume_type = "gp3"
        volume_size = 100
        volume_iops = 3000
        throughput  = 125
      }
    ]

    tags = {
      "fv:service-tier"         = "Operational Application"
      "fv:shared"               = "No"
      "fv:uptime-hrs"           = "24x7"
      "fv:service-type"         = "Application"
    }

    volume_tags = {
      DataClass = "application"
    }
  }

  web = {
    name_prefix              = "CBXWEB"
    ami_id                   = "ami-0123456789abcdef1"
    instance_count           = 1
    starting_instance_number = 1
    default_instance_type    = "t3.medium"
    subnet_ids               = ["subnet-cccccccc"]
    vpc_security_group_ids   = ["sg-bbbbbbbb"]

    root_volume = {
      volume_type = "gp3"
      volume_size = 60
      volume_iops = 3000
      throughput  = 125
    }

    ebs_block_devices = [
      {
        name_suffix = "weblogs"
        device_name = "/dev/sdf"
        volume_type = "gp3"
        volume_size = 80
        volume_iops = 3000
        throughput  = 125
      }
    ]

    tags = {
      "fv:uptime-hrs"           = "24x7"
      "fv:service-type"         = "Web"
      "fv:service-tier"         = "Operational Web"
      "fv:shared"               = "No"
    }

    volume_tags = {
      DataClass = "web"
    }
  }

  dba = {
    name_prefix              = "CBXDBA"
    ami_id                   = "ami-0123456789abcdef2"
    instance_count           = 1
    starting_instance_number = 1
    default_instance_type    = "r6i.xlarge"
    subnet_ids               = ["subnet-dddddddd"]
    vpc_security_group_ids   = ["sg-cccccccc"]

    root_volume = {
      volume_type = "gp3"
      volume_size = 100
      volume_iops = 3000
      throughput  = 125
    }

    ebs_block_devices = [
      {
        name_suffix = "dbdata"
        device_name = "/dev/sdf"
        volume_type = "gp3"
        volume_size = 500
        volume_iops = 6000
        throughput  = 250
      },
      {
        name_suffix = "dblogs"
        device_name = "/dev/sdg"
        volume_type = "gp3"
        volume_size = 250
        volume_iops = 6000
        throughput  = 250
      }
    ]

    tags = {
      "fv:uptime-hrs"           = "24x7"
      "fv:service-type"         = "Database"
      "fv:service-tier"         = "Operational Database"
      "fv:shared"               = "No"
    }

    volume_tags = {
      DataClass = "DB"
    }
  }
}
