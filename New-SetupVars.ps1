function New-SetupVars
{
    param(
        [Parameter(Mandatory=$false)]
        [SecureString]$password
    )

    [sting]$file = Join-Path $PSScriptRoot 'setupVars.conf';
    Clear-Content -Path $file;

    Add-content -Path $file -Value 'PIHOLE_DNS_1=8.8.8.8'
    Add-content -Path $file -Value 'PIHOLE_DNS_2=8.8.4.4'
    Add-content -Path $file -Value "PIHOLE_INTERFACE=eth0"
    Add-content -Path $file -Value 'BLOCKING_ENABLED=true'
    Add-content -Path $file -Value 'QUERY_LOGGING=true'
    Add-content -Path $file -Value 'INSTALL_WEB_SERVER=true'
    Add-content -Path $file -Value 'INSTALL_WEB_INTERFACE=true'
    Add-content -Path $file -Value 'LIGHTTPD_ENABLED=true'
    Add-content -Path $file -Value 'DNSMASQ_LISTENING=all'

    if($password -ne $null) {
        . (Join-Location $PSScriptRoot 'Get-PasswordHash.ps1');
        [string]$passwordhash = Get-PasswordHash -Password $password;
        Add-content -Path $file -Value "WEBPASSWORD=$passwordhash";
    }
}