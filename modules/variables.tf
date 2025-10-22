variable "rgname" {
    type = string
    description = "used for resource group name while creating Resource Group."
}

variable "rglocation" {
    type = string
    description = "used for selecting Resource group location name."
    default = "east US"
}

variable "prefix" {
    type = string
    description = "It is used as the starting part for every resource name"
}

variable "vnet_cidr_prefix" {
    type = string
    description = "It is used as the starting part for every resource name"
}

variable "subnet1_cidr_prefix" {
    type = string
    description = "It is used as the starting part for every resource name"
}

variable "subnet" {
    type = string
    description = "It is used as the starting part for every resource name"
}
