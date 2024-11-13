# Prompt for Tenant ID and Subscription ID
$tenantId = Read-Host -Prompt "Enter your Tenant ID"
$subscriptionId = Read-Host -Prompt "Enter your Subscription ID"

# Installing the Az module
Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force

# Importing the Az module
Import-Module Az.Accounts -Force

# Connecting to Azure Account
Connect-AzAccount -TenantId $tenantId

# Selecting the Azure Subscription
Set-AzContext -SubscriptionId $subscriptionId

# Creating a resource group in Azure East US region
New-AzResourceGroup -Name "az-vm-webserver" -Location "East US"
