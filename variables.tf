variable "enviro" {
  type        = string
  description = "define the environment ex. dev,tst,prd,stg"
}

variable "prjname" {
  type        = string
  description = "define the project name ex. prj02"
}

variable "orgname" {
  type        = string
}

variable "prjnum" {
  type        = string
  description = "define the project number for TFstate file ex. 4858"
}

variable "location" {
  type        = string
  description = "location of your resource group"
}

variable "bastionrgname" {
  type        = string
  description = "the name of the resource group in which to deploy the bastion"
}

variable "nsgrgname" {
  type        = string
  description = "the name of the resource group in which to deploy the nsg"
}

variable "AzureBastionSubnet_ID" {
  type        = string
  description = "the reosurce ID of the AzureBastionSubnet subnet"
}
variable "Bastion_Public_IP_ID" {
  type        = string
  description = "the resource ID of the Bastion_Public_IP address"
}

variable "name" {
  type  = string
}