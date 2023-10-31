provider "zerotier" {}

# These generate random member identities; should try to make work only if not provided.
resource "zerotier_identity" "alice" {}
resource "zerotier_identity" "bob" {}

resource "zerotier_network" "target" {
  name        = var.network.name
  description = var.network.desc
  
  assignment_pool {
    start = "192.168.42.1"
    end   = "192.168.42.254"
  }
  
  route {
    target = "192.168.42.0/24"
  }
  
  assign_ipv4 {
    zerotier = true
  }

  assign_ipv6 {
    zerotier = true
    sixplane = false
    rfc4193  = false
  }

  enable_broadcast = true
  private          = false
  flow_rules       = "accept;"
}

resource "zerotier_member" "each" {
  for_each = var.members
  name        = each.value.name
  member_id   = each.value.id
  description = each.value.desc
  network_id  = zerotier_network.target.id
  hidden                  = true
  allow_ethernet_bridging = true
  no_auto_assign_ips      = true
  ip_assignments          = ["10.0.0.1"]
}
