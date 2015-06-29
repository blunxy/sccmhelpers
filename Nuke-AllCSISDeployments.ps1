if ($ourdeps -eq $null) {
    $ourdeps = Get-CMDeployment | where {$_.SoftwareName -match "^CSIS" }
}

foreach ($dep in $ourdeps) {
    Remove-CMDeployment -ApplicationName $dep.SoftwareName -DeploymentId $dep.DeploymentID -Force
}