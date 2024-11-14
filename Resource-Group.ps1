# Define variables
$resourceGroupName = "az-vm-webserver"
$location = "East US"

# Prompt for Tenant ID and Subscription ID
$tenantId = Read-Host -Prompt "Enter your Tenant ID"
$subscriptionId = Read-Host -Prompt "Enter your Subscription ID"

# Check if the Az module is installed, and install if needed
if (-not (Get-Module -ListAvailable -Name Az)) {
    Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force
}

# Importing the Az module
Import-Module Az.Accounts -Force

# Connecting to Azure Account
Connect-AzAccount -TenantId $tenantId

# Selecting the Azure Subscription
Set-AzContext -SubscriptionId $subscriptionId

# Creating a resource group in Azure East US region
New-AzResourceGroup -Name $resourceGroupName -Location $location
