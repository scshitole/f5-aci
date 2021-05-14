
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
  port = var.port
}

module "bigip_vlan_selfip" {
 source = "./modules/vlan_selfip"
 }

data "template_file" "init" {
  template = "${file("as3.tpl")}"
  vars = {
    TENANT = var.tenant
    APPLICATION = var.application
    VIP_ADDRESS = var.vip_address
    SERVER1 = var.server1
    SERVER2 = var.server2
  }
}

//deploy an application using AS3
resource "bigip_as3"  "as3-example1" {
     as3_json = data.template_file.init.rendered
     depends_on = ["module.bigip_vlan_selfip"]
 }
