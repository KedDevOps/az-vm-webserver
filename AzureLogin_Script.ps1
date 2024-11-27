# Check if the Az module is installed, and install if needed
if (-not (Get-Module -ListAvailable -Name Az)) {
    Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force
}

# Importing the Az module
Import-Module Az.Accounts -Force

# Prompt for Tenant ID and Subscription ID
$tenantId = Read-Host -Prompt "Enter your Tenant ID"
$subscriptionId = Read-Host -Prompt "Enter your Subscription ID"

# Connecting to Azure Account
Connect-AzAccount -TenantId $tenantId

# Selecting the Azure Subscription
Set-AzContext -SubscriptionId $subscriptionId