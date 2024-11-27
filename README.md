# az-vm-webserver
This project guides the setup of an Azure Virtual Machine (VM) along with the deployment of a web server (Nginx) on Ubuntu.


**Goal:**
Set up cloud resources on Azure, deploy a Virtual Machine, configure networking, and run a web server.

**Project Steps:**
1. Create a Resource Group
      - Set up a new resource group in Azure.
    
2. Deploy a Virtual Network (VNet)
      - Create a virtual network within your resource group.
      - Define a subnet in this VNet to segment and organize your resources.
    
3. Deploy a Virtual Machine (VM)
      - Choose an OS, like Ubuntu or Windows Server.
      - For Ubuntu, set up SSH key authentication for security. For Windows Server, use a password.
      - Assign the VM to the subnet created in the VNet.

4. Configure Network Security Groups (NSG)
      - Add inbound rules to allow only necessary traffic.
      - Open port 22 for SSH (Linux).
      - Add a rule for port 80 if you intend to host a web server like Nginx.
    
5. Install and Run a Web Server (Nginx)
      - SSH or RDP into the VM.
      - For Ubuntu, install Nginx
      - Confirm that Nginx is running by navigating to the VM’s public IP address in a browser.
        
6. Monitoring and Alerts
      - Set up Azure Monitor to track CPU, memory, and disk performance.

