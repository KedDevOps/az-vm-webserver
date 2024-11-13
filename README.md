# az-vm-webserver
This project guides the setup of an Azure Virtual Machine (VM) along with the deployment of a web server (Nginx) on Ubuntu.


**Goal:**
Set up cloud resources on Azure, deploy a Virtual Machine, configure networking, and run a web server.
Project Steps:
Create a Resource Group

Set up a new resource group in Azure, e.g., AzureVMResourceGroup.
Deploy a Virtual Network (VNet)

Create a virtual network within your resource group.
Define a subnet in this VNet to segment and organize your resources.
Deploy a Virtual Machine (VM)

Choose an OS, like Ubuntu or Windows Server.
For Ubuntu, set up SSH key authentication for security. For Windows Server, use a password.
Assign the VM to the subnet created in the VNet.
Configure Network Security Groups (NSG)

Add inbound rules to allow only necessary traffic.
Open port 22 for SSH (Linux) or port 3389 for RDP (Windows).
Add a rule for port 80 if you intend to host a web server like Nginx.
Install and Run a Web Server (Nginx)

SSH or RDP into the VM.
For Ubuntu, install Nginx
