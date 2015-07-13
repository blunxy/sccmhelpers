<#
    Create a mandatory deployment that starts right away.
#>
Param(
    [Parameter(Mandatory=$True)]
    [string]$AppName,

    [string]$TargetCollection = "csis-one-off"
)

Remove-CMDeployment -ApplicationName "CSIS_Custom_$AppName" -CollectionName $TargetCollection -Force