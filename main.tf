
terraform {
  required_providers {
    bigip = {
      source  = "f5networks/bigip"
      version = "1.8.0"
    }
  }
}

provider "bigip" {
  address  = var.address
  username = var.username
  password = var.password
  port     = var.port
}

module "bigip_vlan_selfip" {
  source = "./modules/vlan_selfip"
}

module "as3_http_app" {
  source = "./modules/as3http"
}
