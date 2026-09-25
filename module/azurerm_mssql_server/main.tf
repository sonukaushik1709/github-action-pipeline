resource "azurerm_mssql_server" "mssql" {
    for_each = var.mssqls
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
}
output "mssqls" {
    value = {
        for name, m in azurerm_mssql_server.mssql : name => m.id
    }
}

variable "mssqls" {
    type = map(object({
        name                   = string
  resource_group_name          = string
  location                     = string
  version                      = string
  administrator_login          = string
  administrator_login_password = string


    }))
  
}
