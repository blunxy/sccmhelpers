<#
    Create a mandatory deployment that starts right away.
#>
Param(
    [Parameter(Mandatory=$True)]
    [string]$AppName,

    [string]$TargetCollection = "csis-one-off"
)
$AvailableTime = (Get-Date).AddSeconds(0)
$DeploymentTime = $AvailableTime.AddSeconds(1)

# Start-CMApplicationDeployment  -AvailableDateTime $AvailableTime -DeadlineDateTime $DeploymentTime -DeployAction Install -DeployPurpose Required -UserNotification DisplayAll -CollectionName $TargetCollection -Name "@@AppName" 
Start-CMApplicationDeployment -CollectionName csis-one-off -Name "@@$AppName" -DeployAction Install -DeployPurpose Required -UserNotification DisplayAll -AvailableDateTime $AvailableTime -DeadlineDateTime $DeploymentTime