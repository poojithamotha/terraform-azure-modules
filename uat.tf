module "uatmodule" {
  source = "./modules"
  prefix = "uat"
  vnet_cidr_prefix = "10.30.0.0/16"
  subnet1_cidr_prefix = "10.30.1.0/24"
  rgname = "UATRG"
  subnet = "UATSubnet"
}
