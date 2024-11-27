# Define variables
$resourceGroupName = "az-vm-webserver"
$location = "EastUS"
$nsgName = "AZE-NSG"
$nicName = "AZE-NIC"
$vnetName = "AZE-Vnet"
$subnetName = "AZE-Subnet"

# Create a new NSG
$nsg = New-AzNetworkSecurityGroup `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -Name $nsgName

# Add a rule to allow SSH (port 22)
$nsg = $nsg | Add-AzNetworkSecurityRuleConfig `
    -Name "Allow-SSH" `
    -Access Allow `
    -Protocol Tcp `
    -Direction Inbound `
    -Priority 100 `
    -SourceAddressPrefix "*" `
    -SourcePortRange "*" `
    -DestinationAddressPrefix "*" `
    -DestinationPortRange 22

# Add a rule to allow HTTP (port 80)
$nsg = $nsg | Add-AzNetworkSecurityRuleConfig `
    -Name "Allow-HTTP" `
    -Access Allow `
    -Protocol Tcp `
    -Direction Inbound `
    -Priority 200 `
    -SourceAddressPrefix "*" `
    -SourcePortRange "*" `
    -DestinationAddressPrefix "*" `
    -DestinationPortRange 80

# Apply changes to the NSG
$nsg | Set-AzNetworkSecurityGroup

# Get the NIC
$nic = Get-AzNetworkInterface `
    -ResourceGroupName $resourceGroupName `
    -Name $nicName

# Associate the NSG with the NIC
$nic.NetworkSecurityGroup = $nsg
$nic | Set-AzNetworkInterface

# Get the VNet and Subnet
$vnet = Get-AzVirtualNetwork `
    -ResourceGroupName $resourceGroupName `
    -Name $vnetName

$subnet = Get-AzVirtualNetworkSubnetConfig `
    -VirtualNetwork $vnet `
    -Name $subnetName

# Associate the NSG with the Subnet
$subnet.NetworkSecurityGroup = $nsg
$vnet | Set-AzVirtualNetwork
