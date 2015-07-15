<#
    Create a mandatory deployment that starts right away.
#>
Param(
    [Parameter(Mandatory=$True)]
    [string]$AppName
)


Start-CMContentDistribution -ApplicationName "CSIS_Custom_$AppName" -DistributionPointGroupName MRU