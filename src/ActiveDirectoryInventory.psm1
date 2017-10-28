# Implement your module commands in this script.
# Prefix = ADI

function Test-ADIActiveDirectoryModule
{
    <#
    .SYNOPSIS
    Test if ActiveDirectory Module is installed

    .DESCRIPTION
    Test if ActiveDirectory Module is installed

    .EXAMPLE
    Test-ADIActiveDirectoryModule

    Test if ActiveDirectory Module is installed.

    .NOTES
    Author: Constantin Hager
    Date: 28.10.2017
    #>

    if ([String]::IsNullOrEmpty(((Get-Module -ListAvailable).Where{$_.Name -eq 'ActiveDirectory'}).Name))
    {
        return $false
    }
    else
    {
        return $true
    }
}

function Install-ADIActiveDirectoryPowerShellModule
{
    <#
    .SYNOPSIS
    Installes the PowerShell Module for Active Directory

    .DESCRIPTION
    Installes the PowerShell Module for Active Directory.

    If you are on a Windows Server you do not need to provide a URL.
    The function will use Install-WindowsFeature.

    If you are on a Client OS you have to provide the URL to the MSU file
    for the RSAT Tools and a Download location.

    The routine will check if the URL that you provided contains the string msu.
    If it does not then the function will return an error and exit.

    After that It will check if the downloadlocation where the MSU-File will be downloaded
    to exist. If It does not exist the function will return an error and exit.

    If the download location exists the function tries to download the MSU-File from the
    URL that you provided to the Downloadlocation that you provided.

    If the download was successful the installation of the RSAT tools starts immediately
    and waits for It till It is finished.

    .PARAMETER IsWindowsServer
    If you provide this Parameter you tell the function that you are on a Windows Server.
    You do not have to provide a InstallURL or a DownloadPath.

    .PARAMETER InstallURL
    The URL where the MSU-File for the RSAT Tools can be downloaded.
    Example: https://download.microsoft.com/download/1/D/8/1D8B5022-5477-4B9A-8104-6A71FF9D98AB/WindowsTH-RSAT_WS_1709-x64.msu

    .PARAMETER DownloadPath
    The Path where the MSU-File for RSAT-Tools will be stored.

    .EXAMPLE
    $param_download = @{
        InstallURL   = 'https://download.microsoft.com/download/1/D/8/1D8B5022-5477-4B9A-8104-6A71FF9D98AB/WindowsTH-RSAT_WS_1709-x64.msu'
        DownloadPath = 'C:\Temp\'
    }
    Install-ADIActiveDirectoryPowerShellModule @param_download
    Downloads the RSAT-Tools from the URL https://download.microsoft.com/download/1/D/8/1D8B5022-5477-4B9A-8104-6A71FF9D98AB/WindowsTH-RSAT_WS_1709-x64.msu
    and downloads It to C:\Temp and installs It afterwards

    .EXAMPLE
    Install-ADIActiveDirectoryPowerShellModule -IsWindowsServer
    Installs the PowerShell Module for ActiveDirectory on a Windows Server

    .NOTES
    General notes
    #>

    [CmdletBinding()]
    param
    (
        [Parameter(ParameterSetName = 'ServerOS')]
        [switch]
        $IsWindowsServer,

        [Parameter(Mandatory, ParameterSetName = 'ClientOS')]
        [String]
        $InstallURL,

        [Parameter(Mandatory, ParameterSetName = 'ClientOS')]
        [String]
        $DownloadPath
    )

    if (-not($InstallURL.Contains('msu')))
    {
        Write-Error -Message 'Not the right URL. Please Provide the url for the Windows Update Package.'
        exit
    }

    $MachineOS = (Get-CimInstance -ClassName Win32_OperatingSystem).Name

    if ($PSBoundParameters.ContainsKey('IsWindowsServer'))
    {
        IF ($MachineOS -like "*Microsoft Windows Server*")
        {
            Write-Output -InputObject 'You are on a Windows Server. No additional URL Needed.'
            Add-WindowsFeature RSAT-AD-PowerShell
            Break
        }
    }

    Write-Output -InputObject 'You are on a Client OS. Download the RSAT Tools from the URL you provided.'

    Write-Output -InputObject 'Check if downloadpath exist.'
    if (-not(Test-Path $DownloadPath))
    {
        Write-Error ('Downloadpath {0} does not exist. Please Create It First' -f $DownloadPath)
        exit
    }

    $rsatdownloadpath = Join-Path -Path $DownloadPath -ChildPath "rsat.msu"
    if (Test-Path -Path $rsatdownloadpath)
    {
        Write-Output -InputObject 'Found a file with the name rsat.msu. No need to download the file anymore.'
    }
    else
    {
        Write-Output -InputObject ('rsat.msu was not found. Download the file from the URL {0}.' -f $InstallURL)
        try
        {
            Write-Output -InputObject ('Try to Download the RSAT Tools from the URL {0} to {1}' -f $InstallURL, $DownloadPath)
            Invoke-WebRequest -Uri $InstallURL -UseBasicParsing -OutFile $rsatdownloadpath
            Write-Output -InputObject ('Download of the RSAT Tools from the URL {0} to {1} was successful.' -f $InstallURL, $DownloadPath)
        }
        catch
        {
            Write-Error -Message 'There where problems with your internetconnection or you provided the wrong URL.'
            exit
        }
    }

    $WusaArguments = $rsatdownloadpath + " /quiet"
    Write-host "Installing RSAT for Windows 10 - please wait" -ForegroundColor Yellow
    Start-Process -FilePath "C:\Windows\System32\wusa.exe" -ArgumentList $WusaArguments -Wait
}

function Get-ADIForest
{
    param
    (
        [switch]$ApplicationPartitions
    )

    if (Test-ADIActiveDirectoryModule -eq $false)
    {
        # TODO: Implement Install routine
        # AD Module is not installed on Local Computer
        Write-Error -Message "Please install the Active Directory PowerShell Module for your OS.
        You can install the PowerShell Module for Active Directory by yourself or
        run our Integraded CmdLet Install-ADIActiveDirectoryPowerShellModule."
        exit
    }

    if ($PSBoundParameters.ContainsKey('ApplicationsPartitions'))
    {
        #$AllAppPartitions =
    }
}

# Export only the functions using PowerShell standard verb-noun naming.
Export-ModuleMember -Function *-*
