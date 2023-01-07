<#
.SYNOPSIS
    Installs PiHole on Windows using WSL.
#>
param(
    [Parmeter(Mandatory=$false)]
    [SecureString]$Password
)

Write-Verbose 'Loading script dependencies';
. (Join-Location $PSScriptRoot 'Get-IsAdmin.ps1');
. (Join-Location $PSScriptRoot 'New-SetupVars.ps1');
. (Join-Location $PSScriptRoot 'Get-FreeNetworkPort.ps1');
. (Join-Location $PSScriptRoot 'Enable-Wsl.ps1');

if (-not (Get-IsAdmin)) {
    Write-Error "You need to run the Pi-hole installer with administrative rights. Is User Account Control enabled?";
    exit 1;
} else {
    Write-Information "Administrator check passed :-)";
}

Write-Verbose 'Enabling the Windows Subsystem for Linux (WSL)'
Enable-Wsl;

Write-Verbose 'Determining a free network port for admin console';
$port = Get-FreeNetworkPort -StartPort 80;
Write-Information "PiHole Admin console will be hosted on port $port";

Write-Verbose 'Creating PiHole config file';
New-SetupVars -Password $Password;

Write-Verbose 'Building pihole docker image';
docker build -t pihole .

Write-Verbose 'Starting pihole docker container';
docker run -d --name pihole -p 53:53/tcp -p 53:53/udp -p $($port):80/tcp pihole;

Write-Verbose 'determine IP-Address of the docker container'
[string[]]$containerIps = $(docker container inspect pihole --format "{{.NetworkSettings.Networks.nat.IPAddress}}");

Write-Information 'Set the DNS server of physical network cards to the pihole docker container'
[int[]]$interfaceIndices = Get-NetAdapter -Physical | Select-Object -ExpandProperty InterfaceIndex
foreach ($interfaceIndex in $interfaceIndices) {
    Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses $containerIps;
}

Write-Verbose 'Starting PiHole admin page';
Start-Process "http://$env:COMPUTERNAME:$port/admin";