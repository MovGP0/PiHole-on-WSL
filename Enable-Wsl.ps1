<#
.SYNOPSIS
    Enables the Windows Subsystem for Linux (WSL) if it is disabled
#>
function Enable-Wsl
{
    $wslFeature = Get-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux"
    if ($wslFeature.State -eq "Disabled") {
        Enable-WindowsOptionalFeature -FeatureName $wslFeature.FeatureName -Online;
    }
}