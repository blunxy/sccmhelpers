<#
    This roughly grabs all deployments on the MRU SCCM server and nukes them
    if the software in the deployments starts with CSIS. 

    Two issues with this (at least!):
      1) If the app doesn't start with CSIS, well boo-hoo.
      2) Even if the app is being deployed in somebody else's collection (hi, IT!),
      it's gonna go buh-bye.
#>

if ($ourdeps -eq $null) {
    $ourdeps = Get-CMDeployment | where {$_.SoftwareName -match "^CSIS" }
}

foreach ($dep in $ourdeps) {
    Remove-CMDeployment -ApplicationName $dep.SoftwareName -DeploymentId $dep.DeploymentID -Force
}