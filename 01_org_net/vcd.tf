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
  name         = "V2Net1"
  edge_gateway = "EG1"
  gateway      = "192.168.1.254"


  static_ip_pool {
    start_address = "192.168.1.2"
    end_address   = "192.168.1.10"
  }
}

