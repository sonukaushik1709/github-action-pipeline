resource "azurerm_mssql_database" "database" {
    for_each = var.databases
  name         = each.value.name
  server_id    =var.mssqls[each.value.server_id]
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
  enclave_type = each.value.enclave_type

  tags = {
    foo = "bar"
  }

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

variable "mssqls" {
  type  = map(string)

 }


variable "databases"{
    type = map(object({
        name         = string
  server_id    = string
  collation    = string
  license_type = string
  max_size_gb  = number 
  sku_name     = string
  enclave_type = string

    }))
}