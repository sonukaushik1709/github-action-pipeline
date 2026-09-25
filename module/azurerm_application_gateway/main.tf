resource "azurerm_application_gateway" "network" {
  name                = "example-appgateway"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.example.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.example.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}


# resource "azurerm_application_gateway" "network" {
#   for_each = var.app_gateways

#   name                = each.key
#   resource_group_name = each.value.resource_group_name
#   location            = each.value.location

#   sku {
#     name     = "Standard_v2"
#     tier     = "Standard_v2"
#     capacity = each.value.capacity
#   }

#   gateway_ip_configuration {
#     name      = "gw-ip-config"
#     subnet_id = each.value.subnet_id
#   }

#   frontend_port {
#     name = local.frontend_port_name[each.key]
#     port = each.value.frontend_port
#   }

#   frontend_ip_configuration {
#     name                 = local.frontend_ip_configuration_name[each.key]
#     public_ip_address_id = each.value.public_ip_id
#   }

#   backend_address_pool {
#     name = local.backend_address_pool_name[each.key]
#   }

#   backend_http_settings {
#     name                  = local.http_setting_name[each.key]
#     cookie_based_affinity = "Disabled"
#     path                  = each.value.path
#     port                  = each.value.frontend_port
#     protocol              = "Http"
#     request_timeout       = 60
#   }

#   http_listener {
#     name                           = local.listener_name[each.key]
#     frontend_ip_configuration_name = local.frontend_ip_configuration_name[each.key]
#     frontend_port_name             = local.frontend_port_name[each.key]
#     protocol                       = "Http"
#   }

#   request_routing_rule {
#     name                       = local.request_routing_rule_name[each.key]
#     priority                   = 9
#     rule_type                  = "Basic"
#     http_listener_name         = local.listener_name[each.key]
#     backend_address_pool_name  = local.backend_address_pool_name[each.key]
#     backend_http_settings_name = local.http_setting_name[each.key]
#   }
# }
# variable "app_gateways" {
#   description = "List of App Gateways to create"
#   type = map(object({
#     resource_group_name = string
#     location            = string
#     subnet_id           = string
#     public_ip_id        = string
#     frontend_port       = number
#     path                = string
#     capacity            = number
#   }))
# }
# locals {
#   # Generate names dynamically based on key
#   frontend_port_name             = { for k, v in var.app_gateways : k => "${k}-frontend-port" }
#   frontend_ip_configuration_name = { for k, v in var.app_gateways : k => "${k}-frontend-ip" }
#   backend_address_pool_name      = { for k, v in var.app_gateways : k => "${k}-backend-pool" }
#   http_setting_name              = { for k, v in var.app_gateways : k => "${k}-http-setting" }
#   listener_name                  = { for k, v in var.app_gateways : k => "${k}-listener" }
#   request_routing_rule_name      = { for k, v in var.app_gateways : k => "${k}-routing-rule" }
# }
