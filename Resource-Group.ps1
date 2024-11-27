# Define variables
$resourceGroupName = "az-vm-webserver"
$location = "East US"

# Creating a resource group in Azure East US region
New-AzResourceGroup -Name $resourceGroupName -Location $location
