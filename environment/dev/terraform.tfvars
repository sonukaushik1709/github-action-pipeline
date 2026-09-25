rgs = {
  rg1 = {
    name     = "outputblock"
    location = "Japan East"
  }
  rg2 = {
    name     = "outputblock1"
    location = "Japan East"
  }
}

stgs = {
  stg1 = {

    name                     = "outputblockstg"
    location                 = "Japan East"
    resource_group_name      = "outputblock"
    account_tier             = "Standard"
    account_replication_type = "GRS"

  }
}
containers = {
  container1 = {
    name                  = "outputblockcontainer"
    storage_account_id    = "stg1"
    container_access_type = "private"

  }
}

vnets = {
  vnet1 = {
    name                = "outputblock-vnets"
    resource_group_name = "outputblock"
    location            = "Japan East"
    address_space       = ["10.0.0.0/16"]

  }

}

subnets = {
  subnet1 = {
    name                 = "frontend-subnet"
    resource_group_name  = "outputblock"
    virtual_network_name = "outputblock-vnets"
    address_prefixes     = ["10.0.1.0/24"]


  }
  subnet2 = {
    name                 = "backend-subnet"
    resource_group_name  = "outputblock"
    virtual_network_name = "outputblock-vnets"
    address_prefixes     = ["10.0.2.0/24"]


  }
}

nsgs = {
  nsg1 = {
    name                = "frontend-subnet-nasg"
    location            = "Japan East"
    resource_group_name = "outputblock"
    tags = {
      environment = "dev"
    }
    security_rules = {
      rule1 = {
        name                       = "frontend-test123"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"

      }

    }



  }
  nsg2 = {
    name                = "backend-subnet-nasg"
    location            = "Japan East"
    resource_group_name = "outputblock"
    tags = {
      environment = "dev"
    }
    security_rules = {
      rule2 = {
        name                       = "backend-test123"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"

      }

    }



  }
}

associations = {
  association1 = {
    subnet_id                 = "subnet1"
    network_security_group_id = "nsg1"

  }
  association2 = {
    subnet_id                 = "subnet2"
    network_security_group_id = "nsg2"

  }
}

pips = {
  pip1 = {
    name                = "frontend-vm-pip"
    resource_group_name = "outputblock"
    location            = "Japan East"
    allocation_method   = "Static"

    tags = {
      environment = "dev"
    }

  }
  pip2 = {
    name                = "backend-vm-pip"
    resource_group_name = "outputblock"
    location            = "Japan East"
    allocation_method   = "Static"

    tags = {
      environment = "dev"
    }

  }
}

nics = {
  nic1 = {
    name                = "frontend-nic-vm"
    location            = "Japan East"
    resource_group_name = "outputblock"
    ip_configurations = {
      ip1 = {
        name                          = "internal"
        subnet_id                     = "subnet1"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "pip1"

      }
    }


  }
  nic2 = {
    name                = "backend-nic-vm"
    location            = "Japan East"
    resource_group_name = "outputblock"
    ip_configurations = {
      ip2 = {
        name                          = "internal"
        subnet_id                     = "subnet2"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "pip2"

      }
    }


  }
}

vms = {
  vm1 = {
    name                            = "fromten-vm"
    location                        = "Japan East"
    resource_group_name             = "outputblock"
    size                            = "Standard_D2s_v3"
    admin_username                  = "abc"
    admin_password                  = "ramshayam@1234"
    network_interface_ids           = "nic1"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"


  }
  vm2 = {
    name                            = "backend-vm"
    location                        = "Japan East"
    resource_group_name             = "outputblock"
    size                            = "Standard_D2s_v3"
    admin_username                  = "abc"
    admin_password                  = "ramshayam@1234"
    network_interface_ids           = "nic2"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"


  }
}

mssqls = {
  massql1 = {
    name                         = "outputblock-mssql"
    resource_group_name          = "outputblock"
    location                     = "Japan East"
    version                      = "12.0"
    administrator_login          = "abc"
    administrator_login_password = "ramshayam@1234"


  }
}

databases = {
  database1 = {

    name         = "outputblock-databse"
    server_id    = "massql1"
    collation    = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    max_size_gb  = 2
    sku_name     = "S0"
    enclave_type = "VBS"


  }
}

keyvaults = {
  keyvault1 = {
    name                        = "outputblock-keyvault"
    location                    = "Japan East"
    resource_group_name         = "outputblock"
    enabled_for_disk_encryption = true
    tenant_id                   = "4da28509-c586-4d57-a4d1-1280116acfc5"
    object_id                   = "d2438629-f706-4088-adf2-8d924898f464"
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"


  }
}
aksc = {
  aks1 = {
     name                = "outputblock-akc"
  location            = "Japan East"
  resource_group_name = "outputblock"
  dns_prefix   = "exampleaks1"


  }
}

lbs = {
  ib1 = {
     name           = "outputblock-lb"
  location            = "Japan East"
  resource_group_name = "outputblock"
  frontend_ip_configuration = {
    frontend_ip_configuration1 = {
      name                 = "outputblock-frontend_ip_configuration"
    public_ip_address_id = "pip3"

    }
  }


  }
}


# app_gateways = {
#   appgateway1 = {
#     resource_group_name = "rg-dev"
#     location            = "Japan East"
#     subnet_id           = "/subscriptions/xxxx/resourceGroups/rg-dev/providers/Microsoft.Network/virtualNetworks/vnet-dev/subnets/subnet-appgw"
#     public_ip_id        = "/subscriptions/xxxx/resourceGroups/rg-dev/providers/Microsoft.Network/publicIPAddresses/pip-appgw1"
#     frontend_port       = 80
#     path                = "/app1/"
#     capacity            = 2
#   }

#   appgateway2 = {
#     resource_group_name = "rg-dev"
#     location            = "Japan East"
#     subnet_id           = "/subscriptions/xxxx/resourceGroups/rg-dev/providers/Microsoft.Network/virtualNetworks/vnet-dev/subnets/subnet-appgw"
#     public_ip_id        = "/subscriptions/xxxx/resourceGroups/rg-dev/providers/Microsoft.Network/publicIPAddresses/pip-appgw2"
#     frontend_port       = 8080
#     path                = "/app2/"
#     capacity            = 1
#   }
# }
