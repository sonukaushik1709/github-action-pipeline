resource "azurerm_subnet" "subnet" {
    for_each  = var.subnets
    name = each.value.name
    resource_group_name = each.value.resource_group_name
     virtual_network_name = each.value.virtual_network_name
    address_prefixes  = each.value.address_prefixes
}

output "subnets" {
    value = {
        for name, s in azurerm_subnet.subnet : name => s.id
    }
}
variable "subnets" {
    type = map(object({
         name = string
    resource_group_name = string
     virtual_network_name = string
    address_prefixes = list(string)


    }))
  
}
