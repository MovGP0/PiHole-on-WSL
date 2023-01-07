<#
.SYNOPSIS
    Checks if the current user is Administrator
#>
function Get-IsAdmin()
{
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent();
    $role = [Security.Principal.WindowsBuiltInRole]'Administrator';
    $result = [Security.Principal.WindowsPrincipal]($identity).IsInRole($role);
    return $result;
}