Function GetAppRegistryKey($AppName, $AppVersion)
{
    $TweakedAppName = $AppName.Replace("-","")
    $TweakedAppName = $TweakedAppName.Replace(" ",".")
    $TweakedAppName = $TweakedAppName.ToLower()
    "$TweakedAppName.$AppVersion"
}

$APP_NAME = "_ZoomIt"
$APP_VERSION = "4.5"
$APP_REGKEY = GetAppRegistryKey $APP_NAME $APP_VERSION
$CONTENT_LOCATION = "\\ad\empl\IT\MergeInstall1\Utils\csis-bats\+install-script-repo\$APP_REGKEY"

#### Create a new app


$AppParams = @{
    'Name' = $APP_NAME;
    'Owner' = 'Jordan P';
    'SoftwareVersion' = $APP_VERSION;
}

$Newapp = New-CMApplication @AppParams

Move-CMObject -FolderPath 'MTR:\Application\CompSci' -InputObject $NewApp


#### Set up Deployment


$DeploymentParams = @{

    'DeploymentTypeName' = 'MACO-install-script'
    'InstallCommand' = 'install.cmd';
    'ScriptLanguage' = 'VBScript'
    'ContentLocation' = $CONTENT_LOCATION;
    'EstimatedRunTimeMins' = 20;
    'InstallationBehaviorType' = 'InstallForSystem';
    'LogonRequirementType' = 'WhereOrNotUserLoggedOn';
    'MaximumRuntimeMins' = 90;    
}


$DetectionScript = @"
Set oReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")

If oReg.EnumKey(, "Software\CSISCustomInstalls\${APP_REGKEY}", "") = 0 Then
  wspcript.echo "Key Exists"
End If
"@

Add-CMScriptDeploymentType @DeploymentParams -ApplicationName $Newapp.LocalizedDisplayName -ScriptText $DetectionScript

Start-CMContentDistribution -ApplicationName $APP_NAME -DistributionPointGroupName 'MRU'