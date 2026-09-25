resource "azurerm_subnet_network_security_group_association" "example" {
  for_each = var.associations
  subnet_id                 = var.subnets[each.value.subnet_id]
  network_security_group_id = var.nsgs[each.value.network_security_group_id]
}

variable "associations" {
  type = map(object({
     subnet_id                 = string
  network_security_group_id  = string

  }))

}
variable "nsgs"{
  type = map(string)
}
variable "subnets"{
  type = map(string)
}