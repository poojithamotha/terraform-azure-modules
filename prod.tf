module "prodmodule" {
  source = "./modules"
  prefix = "prod"
  vnet_cidr_prefix = "10.40.0.0/16"
  subnet1_cidr_prefix = "10.40.1.0/24"
  rgname = "ProdRG"
  subnet = "ProdSubnet"
}
