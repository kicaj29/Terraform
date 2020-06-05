


##################################################################################
# PROVIDERS
##################################################################################

# Configure the Azure Provider
provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
 }

##################################################################################
# RESOURCES
##################################################################################

resource "azurerm_app_service" "dn-cel-test-jacek99999-dev" {
  name                = "dn-cel-test-jacek99999-dev"
  location            = "West Europe"
  resource_group_name = "AppServicesDev"
  app_service_plan_id = "${var.azure_app_service_plan_id}"
}

##################################################################################
# OUTPUT
#################################################################################
output "app_service_id" {
  value = "${azurerm_app_service.dn-cel-test-jacek99999-dev.id}"
}