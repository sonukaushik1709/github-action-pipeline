resource "azurerm_storage_account" "stg"{
    for_each = var.stgs
    name = each.value.name
    location = each.value .location
    resource_group_name = each.value.resource_group_name
    account_tier = each.value.account_tier
    account_replication_type = each.value.account_replication_type
}
output "stgs" {
    value = {
        for name, s in azurerm_storage_account.stg : name => s.id
    }
    
  
}

variable "stgs"{
    type = map(object({
        name = string
    location = string
    resource_group_name = string
    account_tier = string
    account_replication_type = string
        

    }))
}