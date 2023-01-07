<#
.SYNOPSIS
    Gets a free network port
#>
function Get-FreeNetworkPort
{
    [OutputType([int])]
    param
    (
        [int]$StartPort = 8080
    )

    $port = $StartPort;
    while (((Test-NetConnection $env:COMPUTERNAME -Port $port -WarningAction 'Ignore').TcpTestSucceeded) -eq $true) {
        $port += 1;
    }
    return $port;
}