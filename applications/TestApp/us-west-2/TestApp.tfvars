aws_region           = "us-west-2"
key_name             = "test-tf-key"
iam_instance_profile = "EC2-Role"

enable_monitoring             = true
enable_drift_detection        = true
enable_termination_protection = true
protect_from_destroy          = true
protect_data_volumes          = true
force_detach_volumes          = false

# Tags applied to all resources
common_tags = {
  "fv:data-classification"  = "PHI"
  "fv:cmdb-app-id"          = "TestApp"
  "fv:cmdb-number"          = "SNSVC0000000"
  "fv:business-criticality" = "4"
  "map-migrated"            = "migPL6IW8ZEV2"
  "fv:environment"          = "Build"
  "fv:aws-account-id"       = "897729106068"
  "fv:app-supp-group"       = "Application Support and Solutions (ASST)"
  "fv:it-cost-center"       = "10000-70000-8000"
  "fv:department"           = "Application Support and Solutions (ASST)"
  "fv:app-name"             = "TestApp_NPrd"
  "fv:it-app-owner"         = "TestApp Technical Services"
  "fv:resource-type"        = "EC2 Instance"
}

common_volume_tags = {
  "fv:resource-type" = "EBS Volume"
}

servers = {
  app = {
    name_prefix              = "a2ntstappapp0"
    ami_id                   = "ami-0952adfd00eb27814"
    instance_count           = 4
    starting_instance_number = 1
    default_instance_type    = "t3.medium"
    instance_types_by_name = {
      a2ntstappapp001 = "t3.xlarge"
      a2ntstappapp002 = "t3.large"
    }

    subnet_ids             = ["subnet-0b9b87586541aa73b", "subnet-0c3fa1bf225332a2f"]
    vpc_security_group_ids = ["sg-0e51c2772cf8a4d1a"]

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
      "fv:service-tier" = "Operational Application"
      "fv:shared"       = "No"
      "fv:uptime-hrs"   = "24x7"
      "fv:service-type" = "Application"
    }

    volume_tags = {
      DataClass = "application"
    }
  }

  web = {
    name_prefix              = "a2ntstappweb0"
    ami_id                   = "ami-0952adfd00eb27814"
    instance_count           = 1
    starting_instance_number = 1
    default_instance_type    = "t3.medium"
    subnet_ids               = ["subnet-0b9b87586541aa73b"]
    vpc_security_group_ids   = ["sg-0e51c2772cf8a4d1a"]

    root_volume = {
      volume_type = "gp3"
      volume_size = 80
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
      "fv:service-tier" = "Operational Web"
      "fv:shared"       = "No"
      "fv:uptime-hrs"   = "24x7"
      "fv:service-type" = "Web"
    }

    volume_tags = {
      DataClass = "web"
    }
  }

  db = {
    name_prefix              = "a2ntstappsql0"
    ami_id                   = "ami-0952adfd00eb27814"
    instance_count           = 1
    starting_instance_number = 1
    default_instance_type    = "t3.large"
    subnet_ids               = ["subnet-0c3fa1bf225332a2f"]
    vpc_security_group_ids   = ["sg-0e51c2772cf8a4d1a"]

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
        volume_size = 100
        volume_iops = 6000
        throughput  = 125
      },
      {
        name_suffix = "dblogs"
        device_name = "/dev/sdg"
        volume_type = "gp3"
        volume_size = 80
        volume_iops = 3000
        throughput  = 125
      }
    ]

    #####Tags Applied to All Resources#####
    tags = {
      "fv:uptime-hrs"   = "24x7"
      "fv:service-type" = "Database"
      "fv:service-tier" = "Operational Database"
      "fv:shared"       = "No"
    }

    volume_tags = {
      DataClass = "db"
    }
  }
}
