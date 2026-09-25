resource "azurerm_linux_virtual_machine" "vm"{
    
    for_each = var.vms
    name = each.value.name
    location = each.value.location
    resource_group_name = each.value.resource_group_name
     size  = each.value.size
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password

    network_interface_ids = [
    var.nics[each.value.network_interface_ids]
  ]
    disable_password_authentication = each.value.disable_password_authentication


     os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }

}
variable "nics"{
  type = map(string)
}

variable "vms"{
    type = map(object({
        name = string
    location = string
    resource_group_name = string
     size  = string
    admin_username = string
    admin_password = string
    network_interface_ids= string
    disable_password_authentication = string
    caching              = string
    storage_account_type =string
    publisher = string
    offer     = string
    sku       = string
    version   = string



    }))
}