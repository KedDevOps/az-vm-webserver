# Define variables
$resourceGroupName = "az-vm-webserver"
$vmName = "AZE-VM"
$location = "EastUS"

# Install the Az.Monitor module if not already installed
if (-not (Get-Module -ListAvailable -Name Az.Monitor)) {
    Install-Module -Name Az.Monitor -Force -AllowClobber -Scope CurrentUser
}

# Import the Az.Monitor module
Import-Module Az.Monitor

# Create a Log Analytics workspace
$workspace = New-AzOperationalInsightsWorkspace `
    -ResourceGroupName $resourceGroupName `
    -Name "$vmName-Workspace" `
    -Location $location `
    -Sku "PerGB2018"

# Retrieve workspaceId and workspaceKey
$workspaceId = $workspace.CustomerId
$workspaceKey = (Get-AzOperationalInsightsWorkspaceSharedKeys -ResourceGroupName $resourceGroupName -Name "$vmName-Workspace").PrimarySharedKey

# Install the Azure Monitor Linux Agent on the VM
$publicSettings = @{
    "workspaceId" = $workspaceId
}
$protectedSettings = @{
    "workspaceKey" = $workspaceKey
}

Set-AzVMExtension `
    -ResourceGroupName $resourceGroupName `
    -VMName $vmName `
    -Name "OmsAgentForLinux" `
    -Publisher "Microsoft.EnterpriseCloud.Monitoring" `
    -ExtensionType "OmsAgentForLinux" `
    -TypeHandlerVersion "1.0" `
    -Settings $publicSettings `
    -ProtectedSettings $protectedSettings

# Define performance counters for Linux
$performanceCounters = @(
    @{
        "objectName" = "Processor"; 
        "instanceName" = "*"; 
        "counterName" = "% Processor Time"; 
        "intervalSeconds" = 15;
        "name" = "CPU_Performance_Counter"
    },
    @{
        "objectName" = "Memory"; 
        "instanceName" = "*"; 
        "counterName" = "Available MBytes"; 
        "intervalSeconds" = 15;
        "name" = "Memory_Performance_Counter"
    },
    @{
        "objectName" = "LogicalDisk"; 
        "instanceName" = "*"; 
        "counterName" = "% Free Space"; 
        "intervalSeconds" = 15;
        "name" = "Disk_Performance_Counter"
    }
)

# Enable performance counters for CPU, Memory, and Disk in the Log Analytics workspace
foreach ($counter in $performanceCounters) {
    New-AzOperationalInsightsLinuxPerformanceObjectDataSource `
        -ResourceGroupName $resourceGroupName `
        -WorkspaceName "$vmName-Workspace" `
        -ObjectName $counter.objectName `
        -InstanceName $counter.instanceName `
        -CounterName $counter.counterName `
        -IntervalSeconds $counter.intervalSeconds `
        -Name $counter.name  # Specify the Name of the data source
}

# Enable the Azure Automation intelligence pack in the Log Analytics workspace
Set-AzOperationalInsightsIntelligencePack `
    -ResourceGroupName $resourceGroupName `
    -WorkspaceName "$vmName-Workspace" `
    -IntelligencePackName "AzureAutomation"
