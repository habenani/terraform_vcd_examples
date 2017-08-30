variable "org_network" {default="V2Net2"}
variable "edge_gw" {default="EG2"}
provider "vcd" {
  user                 = "user1"
  password             = "Admin!23"
  org                  = "O2"
  url                  = "https://10.0.8.3:443/api"
  vdc                  = "V03"
  max_retry_timeout      = "30"
  allow_unverified_ssl = "true"
}



resource "vcd_network" "net" {
  name         = "${var.org_network}"
  edge_gateway = "${var.edge_gw}"
  gateway      = "192.168.2.254"


  static_ip_pool {
    start_address = "192.168.2.2"
    end_address   = "192.168.2.10"
  }
}

resource "vcd_firewall_rules" "fw" {
  edge_gateway   = "${var.edge_gw}"
  default_action = "allow"

}

resource "vcd_vapp" "centovapp-terr1" {
  name          = "centvm-t1"
  catalog_name  = "c1"
  template_name = "centPrimaryVapp"
	 network_name ="${var.org_network}"
   ip="192.168.2.2"

}

resource "vcd_dnat" "ssh" {
  edge_gateway = "${var.edge_gw}"
  external_ip  = "10.0.0.80"
  port         = 22
  internal_ip  = "192.168.2.2"
  translated_port = 22
}


resource "vcd_snat" "outbound" {
  edge_gateway = "${var.edge_gw}"
  external_ip  = "10.0.0.80"
  internal_ip  = "192.168.2.2"
}

