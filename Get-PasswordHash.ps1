function Get-PasswordHash
{
    [OutputType([string])]
    param
    (
        [Parameter(Mandatory=$true)]
        [SecureString]$password
    )

    [string]$passwd = ConvertFrom-SecureString -AsPlainText -SecureString $Password;
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($passwd);
    $hash = [System.Security.Cryptography.SHA256]::Create().ComputeHash($bytes);
    $hashString = [System.BitConverter]::ToString($hash).Replace('-','');
    return $hashString;
}