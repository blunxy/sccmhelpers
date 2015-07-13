<#
    Create a mandatory deployment that starts right away.
#>
Param(
    [Parameter(Mandatory=$True)]
    [string]$AppName
)


Start-CMContentDistribution -ApplicationName "CSIS_Custom_$AppName" -DistributionPointName svr2-sc2012.ad.mtroyal.ca