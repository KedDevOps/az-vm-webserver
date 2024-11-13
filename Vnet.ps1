# Create a virtual network
$vnet = New-AzVirtualNetwork -ResourceGroupName "az-vm-webserver" -Name "AZE-Vnet" -Location "EastUS" -AddressPrefix "10.0.0.0/16"

# Add a subnet to the virtual network
Add-AzVirtualNetworkSubnetConfig -Name "AZE-Subnet" -AddressPrefix "10.0.0.0/24" -VirtualNetwork $vnet

# Apply the subnet configuration
Set-AzVirtualNetwork -VirtualNetwork $vnet