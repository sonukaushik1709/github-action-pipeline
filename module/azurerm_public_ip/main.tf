resource "azurerm_public_ip" "pip" {
    for_each = var.pips

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method

  tags = each.value.tags
}
output "pips"{
    value = {
        for name, p in azurerm_public_ip.pip : name => p.id

    }
}
variable "pips"{
    type = map(object({
        name                = string
  resource_group_name = string
  location            = string
  allocation_method   = string

  tags = map(string)


    }))
}