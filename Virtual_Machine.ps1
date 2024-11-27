# Define variables
$resourceGroupName = "az-vm-webserver"
$vnetName = "AZE-Vnet"
$location = "EastUS"
$subnetName = "AZE-Subnet"
$vmName = "AZE-VM"
$vmSize = "Standard_B1s"
$adminUsername = "test_user" # Change this to your desired username
$adminPassword = "Test12345" # Change this to a secure password
$publicIpName = "AZE-PublicIP"
$nicName = "AZE-NIC"
$imagePublisher = "Canonical"
$imageOffer = "UbuntuServer"
$imageSku = "18.04-LTS"

# Create a public IP address
$publicIp = New-AzPublicIpAddress `
    -ResourceGroupName $resourceGroupName `
    -Name $publicIpName `
    -Location $location `
    -AllocationMethod Static `
    -Sku Standard

# Get the existing virtual network and subnet
$vnet = Get-AzVirtualNetwork `
    -ResourceGroupName $resourceGroupName `
    -Name $vnetName

$subnet = Get-AzVirtualNetworkSubnetConfig `
    -Name $subnetName `
    -VirtualNetwork $vnet

# Create a network interface
$nic = New-AzNetworkInterface `
    -ResourceGroupName $resourceGroupName `
    -Name $nicName `
    -Location $location `
    -SubnetId $subnet.Id `
    -PublicIpAddressId $publicIp.Id

# Create a virtual machine configuration
$vmConfig = New-AzVMConfig `
    -VMName $vmName `
    -VMSize $vmSize |
    Set-AzVMOperatingSystem `
        -Linux `
        -ComputerName $vmName `
        -Credential (New-Object System.Management.Automation.PSCredential ($adminUsername, (ConvertTo-SecureString $adminPassword -AsPlainText -Force))) |
    Set-AzVMSourceImage `
        -PublisherName $imagePublisher `
        -Offer $imageOffer `
        -Skus $imageSku `
        -Version "latest" |
    Add-AzVMNetworkInterface `
        -Id $nic.Id

# Create the virtual machine
New-AzVM `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -VM $vmConfig
