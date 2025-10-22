
terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=4.1.0"
        }
    }
}

module "devmodule" {
  source = "./modules"
  prefix = "dev"
  vnet_cidr_prefix = "10.20.0.0/16"
  subnet1_cidr_prefix = "10.20.1.0/24"
  rgname = "DevRG"
  subnet = "DevSubnet"
}

