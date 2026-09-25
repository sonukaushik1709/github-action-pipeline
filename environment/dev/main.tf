module "rg" {
  source = "../../module/azurerm_resource_group"
  rgs    = var.rgs
}
module "stg" {
  depends_on = [module.rg]
  source     = "../../module/azurerm_storage_account"
  stgs       = var.stgs
}

module "container" {
  depends_on = [module.rg, module.stg]
  source     = "../../module/azurerm_storage_container"
  containers = var.containers
  stgs       = module.stg.stgs
}

module "vnets" {
  depends_on = [module.rg]
  source     = "../../module/azurerm_virtual_network"
  vnets      = var.vnets
}

module "subnet" {
  depends_on = [module.rg, module.vnets]
  source     = "../../module/azurerm_subnet"
  subnets    = var.subnets
}

module "nsg" {
  depends_on = [module.rg]
  source     = "../../module/azurerm_network_security_group"
  nsgs       = var.nsgs
}

module "association" {
  depends_on   = [module.rg, module.subnet, module.nsg]
  source       = "../../module/azurerm_association"
  associations = var.associations
  subnets      = module.subnet.subnets
  nsgs         = module.nsg.nsgs
}
module "pip" {
  depends_on = [module.rg]
  source     = "../../module/azurerm_public_ip"
  pips       = var.pips
}
module "nic" {
  depends_on = [module.rg, module.pip, module.subnet]
  source     = "../../module/azurerm_network_interface"
  nics       = var.nics
  pips       = module.pip.pips
  subnets    = module.subnet.subnets
}
module "vm" {
  depends_on = [module.rg, module.nic]
  source     = "../../module/azurerm_virtual_machine"
  vms        = var.vms
  nics       = module.nic.nics

}
module "mssql" {
  depends_on = [module.rg]
  source     = "../../module/azurerm_mssql_server"
  mssqls     = var.mssqls
}
module "mssql_databace" {
  source    = "../../module/azurerm_mssql_database"
  databases = var.databases
  mssqls    = module.mssql.mssqls
}
module "keyvault" {
  source    = "../../module/azurem_key_vault"
  keyvaults = var.keyvaults
}

module "aks"{
  depends_on = [module.rg]
  source = "../../module/azurerm_kubernetes_cluster"
  aksc = var.aksc
}