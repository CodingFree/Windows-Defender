[CmdletBinding()]
Param(
  [Parameter(Mandatory=$false)]
  [switch]$scan,

  [Parameter(Mandatory=$false)]
  [switch]$update,

  [Parameter(Mandatory=$false)]
  [switch]$clean,

  [Parameter(Mandatory=$false)]
  [switch]$addRecursive,

  [Parameter(Mandatory=$false)]
  [switch]$optimize
)

Clear-Host

function Add-Exclusions-Recursive
{
  $Directory = (Get-Item -Path ".\" -Verbose).FullName
  $executables = Get-ChildItem -path $Directory -Recurse -Include *.exe
  foreach ($exe in $executables) {
     Add-MpPreference -ExclusionPath $exe.FullName
  }
}

function Remove-Exclusions-All
{ 
  $Preferences = Get-MpPreference
  $Exclusion = $Preferences.ExclusionPath
  foreach ($exe in $Exclusion) {
     Remove-MpPreference -ExclusionPath $exe
  }
}

function Optimize-Settings{
  Set-MpPreference -DisableCatchupFullScan $false
  Set-MpPreference -DisableCatchupQuickScan $false
  Set-MpPreference -SignatureDisableUpdateOnStartupWithoutEngine $false
  Set-MpPreference -RealTimeScanDirection Incoming #Both is more secure
  Set-MpPreference -CheckForSignaturesBeforeRunningScan $true
  Set-MpPreference -SignatureScheduleDay 0 # 0 is every day
  Set-MpPreference -ThreatIDDefaultAction_Actions 2 # Quarantine by default
  #List of actions: https://msdn.microsoft.com/es-es/library/windows/desktop/dn439474%28v=vs.85%29.aspx
  Set-MpPreference -ScanAvgCPULoadFactor 20
  Set-MpPreference -ScanOnlyIfIdleEnabled $true # If CPU is idle, run scheduled scan.
}

function Run-Hardcore-Scan{
  Update-MpSignature
  Set-MpPreference -ScanAvgCPULoadFactor 80
  Start-MpScan -ScanType:FullScan
  // When finished...
  Optimize-Settings
}

function List-Exclusions{
  Write-Host List of Exclusions:
  $Preferences = Get-MpPreference
  $Exclusion = $Preferences.ExclusionPath
  foreach ($exe in $Exclusion) {
     Write-Host $exe
  }
}


if($scan){
  Write-Host Starting hardcore mode...
  Run-Hardcore-Scan
}elseif($update){
  Write-Host Updating the signatures...
  Update-MpSignature
  Write-Host Finished!
}elseif($optimize){
  Write-Host Optimizing Windows Defender...
  Optimize-Settings
  Get-MpPreference
  Write-Host Done!
}elseif($clean){
  Write-Host Removing all Exclusions...
  Remove-Exclusions-All
  List-Exclusions
  Write-Host Removed!
}elseif($addRecursive){
  Write-Host Adding files...
  Add-Exclusions-Recursive
  List-Exclusions
  Write-Host Finished!
}