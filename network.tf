resource "intersight_vnic_eth_if" "eth1" {
  name = "eth0"
  order = 0
  placement {
    id = "1"
    pci_link = 0
    uplink = 0
  }
  cdn {
    value = "VIC-1-eth00"
    nr_source = "user"
  }
  usnic_settings {
    cos = 5
    nr_count = 0
  }
  vmq_settings {
    enabled = true
    multi_queue_support = false
    num_interrupts = 1
    num_vmqs = 1
  }
  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.vnic_lan1.id
    object_type = "vnic.LanConnectivityPolicy"
  }
  eth_network_policy {
    moid = intersight_vnic_eth_network_policy.v_eth_network1.id
  }
  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.v_eth_adapter1.id
  }
  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.v_eth_qos1.id
  }

  tags {
    key   = "Managed_By"
    value = "Terraform"
  }
}

resource "intersight_vnic_eth_if" "eth2" {
  name = "eth1"
  order = 1
  placement {
    id = "1"
    pci_link = 0
    uplink = 0
  }
  cdn {
    value = "VIC-1-eth00"
    nr_source = "user"
  }
  usnic_settings {
    cos = 5
    nr_count = 0
  }
  vmq_settings {
    enabled = true
    multi_queue_support = false
    num_interrupts = 1
    num_vmqs = 1
  }
  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.vnic_lan1.id
    object_type = "vnic.LanConnectivityPolicy"
  }
  eth_network_policy {
    moid = intersight_vnic_eth_network_policy.v_eth_network1.id
  }
  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.v_eth_adapter1.id
  }
  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.v_eth_qos1.id
  }

  tags {
    key   = "Managed_By"
    value = "Terraform"
  }

}

resource "intersight_vnic_eth_network_policy" "v_eth_network1" {
  name = "v_eth_network1"

  vlan_settings {
    object_type = "vnic.VlanSettings"
    default_vlan = 1
    mode = "ACCESS"
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

resource "intersight_vnic_eth_adapter_policy" "v_eth_adapter1" {
  name = "v_eth_adapter1"
  rss_settings = true
  uplink_failback_timeout = 5

  vxlan_settings {
    enabled = false
  }

  nvgre_settings {
    enabled = true
  }

  arfs_settings {
    enabled = true
  }

  interrupt_settings {
    coalescing_time = 125
    coalescing_type = "MIN"
    nr_count = 4
    mode = "MSI"
  }
  completion_queue_settings {
    nr_count = 4
    ring_size = 1
  }
  rx_queue_settings {
    nr_count = 4
    ring_size = 512
  }
  tx_queue_settings {
    nr_count = 4
    ring_size = 512
  }
  tcp_offload_settings {
    large_receive = true
    large_send = true
    rx_checksum = true
    tx_checksum = true
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

resource "intersight_vnic_eth_qos_policy" "v_eth_qos1" {
  name = "v_eth_qos1"
  mtu = 1500
  rate_limit = 0
  cos = 0
  trust_host_cos = false

  tags {
    key   = "Managed_By"
    value = "Terraform"
  }
  
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.id
  }
}

resource "intersight_vnic_lan_connectivity_policy" "vnic_lan1" {
  name = "Morten-VNICs"

  target_platform = "Standalone"

  tags {
    key   = "Managed_By"
    value = "Terraform"
  }
  
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.id
  }
  profiles {
    moid = intersight_server_profile.server1.id
    object_type = "server.Profile"
  }
}