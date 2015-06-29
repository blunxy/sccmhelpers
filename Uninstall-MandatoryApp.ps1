<#
    Create a mandatory uninstall deploy that starts right away.
#>
Param(
    [Parameter(Mandatory=$True)]
    [string]$TargetCollection,

    [Parameter(Mandatory=$True)]
    [string]$AppName
)
$AvailableTime = Get-Date
$DeploymentTime = $AvailableTime.AddSeconds(1)

Start-CMApplicationDeployment -CollectionName $TargetCollection -Name $AppName -DeployAction Uninstall -DeployPurpose Required -UserNotification DisplayAll -AvaliableTime $AvailableTime -DeadlineTime $DeploymentTime
