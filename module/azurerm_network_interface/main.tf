resource "azurerm_network_interface" "nic"{
    for_each = var.nics
    name = each.value.name
    location = each.value.location
    resource_group_name = each.value.resource_group_name
    dynamic "ip_configuration" {
        for_each = each.value.ip_configurations
        content {
            name                          = ip_configuration.value.name
    subnet_id                     = var.subnets[ip_configuration.value.subnet_id]
    private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
    public_ip_address_id = var.pips[ip_configuration.value.public_ip_address_id]

        }
       
    }
}
output "nics" {
    value = {
        for name,n in azurerm_network_interface.nic : name => n.id
    }

}
variable "subnets" {
    type = map(string)
}
variable "pips"{
    type = map(string)
}
variable "nics" {
    type = map(object({
         name = string
    location = string
    resource_group_name = string
     ip_configurations = map(object({

        name                          = string
    subnet_id                     = string
    private_ip_address_allocation = string
    public_ip_address_id = string


    }))
   

    }))
}