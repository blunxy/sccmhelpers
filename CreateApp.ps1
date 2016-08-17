$AppParams = @{
    'Name' = '@Goo';
    'Owner' = 'Jordan P';
    'SoftwareVersion' = '12.3.0';
}

$DeploymentParams = @{

    'DeploymentTypeName' = 'MACO-install-script'
    'InstallCommand' = 'install.cmd';
    'ScriptLanguage' = 'Powershell'
    'ScriptText' = 'some PS script for detection?';
    'ContentLocation' = '\\ad\empl\IT\MergeInstall1\Software PQRS\Steem\steem.2.5b.7\';
    'EstimatedRunTimeMins' = 20;
    'InstallationBehaviorType' = 'InstallForSystem';
    'LogonRequirementType' = 'WhereOrNotUserLoggedOn';
    'MaximumRuntimeMins' = 90;    
}

$Newapp = New-CMApplication @AppParams

Move-CMObject -FolderPath 'MTR:\Application\CompSci' -InputObject $NewApp

Add-CMScriptDeploymentType @DeploymentParams -ApplicationName $Newapp.LocalizedDisplayName