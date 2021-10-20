terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.12"
    }
  }
}

resource "azurerm_bastion_host" "Bastion" {
  name                = format("%s%s%s%s%s%s", "Bast_", var.name, var.orgname, var.prjname, var.enviro, var.prjnum)
  location            = var.location
  resource_group_name = var.bastionrgname
  
  ip_configuration {
    name                 = format("%s%s%s%s%s%s", "ipconfig_bast_", var.name, var.orgname, var.prjname, var.enviro, var.prjnum)
    subnet_id            = var.AzureBastionSubnet_ID
    public_ip_address_id = var.Bastion_Public_IP_ID
  }
}

resource "azurerm_network_security_group" "bast_nsg" {
  name                = format("%s%s%s%s", "bast_nsg_", var.prjname, var.enviro, var.prjnum)
  location            = var.location
  resource_group_name = var.nsgrgname

  security_rule {
        name                       = "GatewayManager"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "Internet-Bastion-PublicIP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "OutboundVirtualNetwork"
        priority                   = 1001
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["22","3389"]
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
    }

     security_rule {
        name                       = "OutboundToAzureCloud"
        priority                   = 1002
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
    }
}

resource "azurerm_subnet_network_security_group_association" "NSGassoc_Bastion_Subnet" {
  subnet_id                 = var.AzureBastionSubnet_ID
  network_security_group_id = azurerm_network_security_group.bast_nsg.id
  }