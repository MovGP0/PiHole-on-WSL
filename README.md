# PiHole-on-WSL

Sample code to create a PiHole server on WSL.

## IMPORTANT NOTE
This is example code and not ready for production environments. Use at your own risk.

## Open issues
- Start the docker container on system startup and dynamically redirect DNS bindings of physical network adapters to the container. 
- Testing, Testing, Testing

## Prerequisites

- Windows Subsystem for Linux (WSL) needs to be installed
    - [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install)

- Docker needs to be installed. 
    - [Install Docker for Windows](https://docs.docker.com/desktop/install/windows-install/)

- Set the ExecutionPolicy of Powershell to `unrestricted`

```powershell
Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
```

## Installation

- Execute the setup script
```powershell
Set-Location './PiHole-on-WSL' # use the proper path

# define a random password for the PiHole web interface
# DO NOT USE THIS EXAMPLE!
$password = ConvertTo-SecureString '&v!N5n!OSfB2#5H1';

# execute the script
. .\setup.ps1 -Password $password
```

## Cleanup

- Set the ExecutionPolicy to the original setting
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy AllSigned
```