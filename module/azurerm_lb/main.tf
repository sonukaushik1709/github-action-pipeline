resource "azurerm_lb" "example" {
    for_each = var.lbs
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  frontend_ip_configuration {
    name                 = each.value.name
    public_ip_address_id = each.value.public_ip_address_id
  }
}

variable "lbs"{
 
    type = map(object({
        name           = string
  location            = string
  resource_group_name = string
  frontend_ip_configuration = map(object({
     name                 = string
    public_ip_address_id = string

  }))


    }))
}