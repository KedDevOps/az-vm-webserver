# Variables
$resourceGroupName = "az-vm-webserver"
$vmName = "AZE-VM"
$location = "EastUS"
$adminUsername = "test_user" # Use the same username you set during VM creation
$sshKeyFilePath = "~/.ssh/id_rsa" # Path to your private SSH key

# Get the Public IP Address of the VM
$publicIp = (Get-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Name "AZE-PublicIP").IpAddress
Write-Host "Public IP Address of the VM: $publicIp"

# SSH Command to install Nginx
$sshCommand = @"
#!/bin/bash
# Update packages
sudo apt update && sudo apt upgrade -y
# Install Nginx
sudo apt install nginx -y
# Ensure Nginx is running
sudo systemctl start nginx
sudo systemctl enable nginx
"@

# Save the command to a script file locally
$sshScriptFilePath = "C:\az-vm-webserver\install_nginx.sh"
Set-Content -Path $sshScriptFilePath -Value $sshCommand

# Correct the SCP command and upload the script to the VM
$sshKeyFilePath = $sshKeyFilePath.Replace('~', [System.Environment]::GetFolderPath('MyDocuments')) # Expand ~ to full path if needed
scp -i "${sshKeyFilePath}" "${sshScriptFilePath}" "${adminUsername}@${publicIp}:/tmp/install_nginx.sh"

# SSH into the VM and execute the script
ssh -i "${sshKeyFilePath}" "${adminUsername}@${publicIp}" "bash /tmp/install_nginx.sh"

# Confirm that Nginx is running
Write-Host "Open a browser and navigate to: http://$publicIp to verify Nginx is running."
