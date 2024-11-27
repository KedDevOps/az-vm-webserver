# Define variables
$resourceGroupName = "az-vm-webserver"
$vnetName = "AZE-Vnet"
$location = "EastUS"
$addressPrefix = "10.0.0.0/16"
$subnetName = "AZE-Subnet"
$subnetPrefix = "10.0.0.0/24"

# Create a virtual network
$vnet = New-AzVirtualNetwork `
    -ResourceGroupName $resourceGroupName `
    -Name $vnetName `
    -Location $location `
    -AddressPrefix $addressPrefix

# Add a subnet to the virtual network
Add-AzVirtualNetworkSubnetConfig `
    -Name $subnetName `
    -AddressPrefix $subnetPrefix `
    -VirtualNetwork $vnet

# Apply the subnet configuration
Set-AzVirtualNetwork `
    -VirtualNetwork $vnet