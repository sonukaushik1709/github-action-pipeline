resource "azurerm_network_security_group" "nsg"{
    
    for_each = var.nsgs
    name = each.value.name
    location = each.value.location
    resource_group_name = each.value.resource_group_name
    dynamic "security_rule" {
        for_each = each.value.security_rules
        content{
             name                       = security_rule.value.name
    priority                   = security_rule.value.priority
    direction                  = security_rule.value.direction
    access                     = security_rule.value.access
    protocol                   = security_rule.value.protocol
    source_port_range          = security_rule.value.source_port_range
    destination_port_range     = security_rule.value.destination_port_range
    source_address_prefix      = security_rule.value.source_address_prefix
    destination_address_prefix = security_rule.value.destination_address_prefix

        }
   
  }
tags = each.value.tags
  
}
output "nsgs" {
  value = {
    for name,n in azurerm_network_security_group.nsg : name => n.id
  }

}

variable "nsgs"{
    type = map(object({
        name = string
    location = string
    resource_group_name = string
    tags                      = map(string)
    security_rules = map(object({
         name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    


    }))
    
    
  }))
   
  
}