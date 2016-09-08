Function GetAppRegistryKey($AppName, $AppVersion)
{
    $TweakedAppName = $AppName.Replace("-","")
    $TweakedAppName = $TweakedAppName.Replace(" ",".")
    $TweakedAppName = $TweakedAppName.ToLower()
    "$TweakedAppName.$AppVersion"
}

$APP_NAME = "vs ent tweak"
$APP_VERSION = "2015.3"


$APP_REGKEY = GetAppRegistryKey $APP_NAME $APP_VERSION
$CONTENT_LOCATION = "\\ad\empl\IT\MergeInstall1\MathComp\sccm.repo\$APP_REGKEY"
$APP_NAME = "MACO.$APP_NAME"

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
    'MaximumRuntimeMins' = 120; 
    'UninstallCommand' = 'uninstall.cmd';   
}


$DetectionScript = @"
Dim oReg
Set oReg = GetObject("winmgmts:!root/default:StdRegProv")

If oReg.EnumKey(, "Software\CSISCustomInstalls\${APP_REGKEY}", "") = 0 Then
  wscript.stdout.write "Key Exists"
End If

wscript.quit(0)
"@

Add-CMScriptDeploymentType @DeploymentParams -ApplicationName $Newapp.LocalizedDisplayName -ScriptText $DetectionScript

# Start-CMContentDistribution -ApplicationName $APP_NAME -DistributionPointGroupName 'MRU'