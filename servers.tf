data "intersight_organization_organization" "org" {
    name = var.organization
}

data "intersight_compute_rack_unit" "rackmount1" {
    serial = "FCH2128V257"
}

resource "intersight_boot_precision_policy" "boot_precision1" {
  name                     = "Morten-Boot-order"
  description              = "test policy"
  configured_boot_mode     = "Legacy"
  enforce_uefi_secure_boot = false

  boot_devices {
    enabled     = true
    name        = "NIIODCIMCDVD"
    object_type = "boot.VirtualMedia"
    additional_properties = jsonencode({
      Subtype = "cimc-mapped-dvd"
    })
  }

  boot_devices {
    enabled     = true
    name        = "hdd"
    object_type = "boot.LocalDisk"
    additional_properties = jsonencode({
      Slot = "MRAID"
      Bootloader = {
        Description = ""
        Name        = ""
        ObjectType  = "boot.Bootloader"
        Path        = ""
      }
    })
  }
  
  profiles {
    moid        = intersight_server_profile.server1.id
    object_type = "server.Profile"
  }
  
  tags {
    key   = "Managed_By"
    value = "Terraform"
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.id
  }
}

resource "intersight_bios_policy" "bios1" {
  name    = "Morten-BIOS-Policy"
  
  profiles {
    moid        = intersight_server_profile.server1.id
    object_type = "server.Profile"
  }
  
  tags {
    key   = "Managed_By"
    value = "Terraform"
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.id
  }
}


resource "intersight_ntp_policy" "ntp1" {
  name    = "Morten-NTP-Policy"
  enabled = true
  ntp_servers = [
    "ntp.esl.cisco.com",
    "time-a-g.nist.gov",
    "time-b-g.nist.gov"
  ]

  profiles {
    moid        = intersight_server_profile.server1.id
    object_type = "server.Profile"
  }
  
  tags {
    key   = "Managed_By"
    value = "Terraform"
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.id
  }
}

resource "intersight_server_profile" "server1" {
  name   = "Morten-Server-TF"
  action = "No-op"

  target_platform = "Standalone"

/*
  assigned_server = [ {
    additional_properties = "value"
    class_id = "mo.MoRef"
    moid = data.intersight_compute_rack_unit.rackmount1.id
    object_type = "compute.RackUnit"
    selector 
  } ]
  */

  tags {
    key   = "Managed_By"
    value = "Terraform"
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.id
  }
}
