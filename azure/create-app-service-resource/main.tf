##################################################################################
# PROVIDERS
##################################################################################

# Configure the Azure Provider
provider "azurerm" {
  subscription_id = "c0dca3aa-f96c-4551-a0d9-6167695198b2"
 }

##################################################################################
# RESOURCES
##################################################################################

resource "azurerm_app_service" "dn-cel-test-jacek-dev" {
  name                = "dn-cel-test-jacek-dev"
  location            = "West Europe"
  resource_group_name = "AppServicesDev"
  app_service_plan_id = "/subscriptions/c0dca3aa-f96c-4551-a0d9-6167695198b2/resourceGroups/AppServicesDev/providers/Microsoft.Web/serverFarms/dn-cel-appserviceplan-dev"
}

##################################################################################
# OUTPUT
#################################################################################
