<#
    Create a mandatory deployment that starts right away.
#>
Param(
    [Parameter(Mandatory=$True)]
    [string]$AppName,

    [string]$TargetCollection = "csis-one-off"
)
$AvailableTime = Get-Date
$DeploymentTime = $AvailableTime.AddSeconds(1)

Start-CMApplicationDeployment -CollectionName $TargetCollection -Name "CSIS_Custom_$AppName" -DeployAction Install -DeployPurpose Required -UserNotification DisplayAll -AvaliableTime $AvailableTime -DeadlineTime $DeploymentTime
