# Implement your module commands in this script.
# Prefix = ADI

#region Class
class ActiveDirectoryInventoryClass
{
    [int]$ID

    [System.Collections.ArrayList] GetApplicationPartitions([System.Collections.ArrayList]$ArrayList)
    {
        $DefaultArrayList = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        foreach ($Item in $ArrayList)
        {
            $row = [PSCustomObject]@{
                ID            = $this.ID
                PartitionName = $Item
            }

            $null = $DefaultArrayList.Add($row)
            $this.ID++
        }

        return $DefaultArrayList
    }

    [System.Collections.ArrayList] GetDomainNamingMaster([System.Collections.ArrayList]$DomainNamingMasters)
    {
        $ArrDomainNamingMasters = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        foreach ($Item in $DomainNamingMasters)
        {
            $row = [PSCustomObject]@{
                ID                 = $this.ID
                DomainNamingMaster = $Item
            }

            $null = $ArrDomainNamingMasters.Add($row)
            $this.ID++
        }

        return $ArrDomainNamingMasters
    }

    [System.Collections.ArrayList] GetDomainNamingMaster([System.String]$SingleDomainNamingMaster)
    {
        $ArrDomainNamingMasters = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        $row = [PSCustomObject]@{
            ID                 = $this.ID
            DomainNamingMaster = $SingleDomainNamingMaster
        }

        $null = $ArrDomainNamingMasters.Add($row)
        return $ArrDomainNamingMasters
    }

    [System.Collections.ArrayList] GetCrossForestReferences([System.Collections.ArrayList]$CrossForestReferences)
    {
        $ArrCrossForestReference = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        foreach ($Item in $CrossForestReferences)
        {
            $row = [PSCustomObject]@{
                ID                   = $this.ID
                CrossForestReference = $Item
            }

            $null = $ArrCrossForestReference.Add($row)
            $this.ID++
        }

        return $ArrCrossForestReference
    }

    [System.Collections.ArrayList] GetCrossForestReferences([System.String]$CrossForestReference)
    {
        $ArrCrossForestReference = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        $row = [PSCustomObject]@{
            ID                   = $this.ID
            CrossForestReference = $CrossForestReference
        }

        $null = $CrossForestReference.Add($row)
        return $CrossForestReference
    }

    [System.Collections.ArrayList] GetDomains([System.Collections.ArrayList]$Domains)
    {
        $ArrDomains = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        foreach ($Item in $Domains)
        {
            $row = [PSCustomObject]@{
                ID     = $this.ID
                Domain = $Item
            }

            $null = $ArrDomains.Add($row)
            $this.ID++
        }

        return $ArrDomains
    }

    [System.Collections.ArrayList] GetDomains([System.String]$Domain)
    {
        $ArrDomains = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        $row = [PSCustomObject]@{
            ID     = $this.ID
            Domain = $Domain
        }

        $null = $ArrDomains.Add($row)
        return $ArrDomains
    }
}
#endregion

#Instanciate Class
$class = New-Object -TypeName ActiveDirectoryInventoryClass

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
        return $true
    }
    else
    {
        return $false
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

    if ($PSBoundParameters.ContainsKey('IsWindowsServer'))
    {
        $MachineOS = (Get-CimInstance -ClassName Win32_OperatingSystem).Name
        IF ($MachineOS -like "*Microsoft Windows Server*")
        {
            Write-Verbose -Message 'You are on a Windows Server. No additional URL Needed.'
            Add-WindowsFeature RSAT-AD-PowerShell
        }
    }

    if ($PSBoundParameters.ContainsKey('InstallURL'))
    {
        if (-not($InstallURL.Contains('msu')))
        {
            Write-Error -Message 'Not the right URL. Please Provide the url for the Windows Update Package.'
            exit
        }
    }

    if ($PSBoundParameters.ContainsKey('DownloadPath'))
    {
        Write-Verbose -Message 'You are on a Client OS. Download the RSAT Tools from the URL you provided.'

        Write-Verbose -Message 'Check if downloadpath exist.'
        if (-not(Test-Path $DownloadPath))
        {
            Write-Error ('Downloadpath {0} does not exist. Please Create It First' -f $DownloadPath)
            exit
        }

        $rsatdownloadpath = Join-Path -Path $DownloadPath -ChildPath "rsat.msu"
        if (Test-Path -Path $rsatdownloadpath)
        {
            Write-Verbose -Message 'Found a file with the name rsat.msu. No need to download the file anymore.'
        }
        else
        {
            Write-Verbose -Message ('rsat.msu was not found. Download the file from the URL {0}.' -f $InstallURL)
            try
            {
                Write-Verbose -Message ('Try to Download the RSAT Tools from the URL {0} to {1}' -f $InstallURL, $DownloadPath)
                Invoke-WebRequest -Uri $InstallURL -UseBasicParsing -OutFile $rsatdownloadpath
                Write-Verbose -Message ('Download of the RSAT Tools from the URL {0} to {1} was successful.' -f $InstallURL, $DownloadPath)
            }
            catch
            {
                Write-Error -Message 'There where problems with your internetconnection or you provided the wrong URL.'
                exit
            }
        }

        $WusaArguments = $rsatdownloadpath + " /quiet"
        Write-Verbose -Message "Installing RSAT for Windows 10 - please wait"
        Start-Process -FilePath "C:\Windows\System32\wusa.exe" -ArgumentList $WusaArguments -Wait
    }
}
function Get-ADIForest
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true, ParameterSetName = 'AdditionalParameters')]
        [string]$ServerName,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [string]$ForestName = (Get-ADForest).Name,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [pscredential]$Credential,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$ApplicationPartitions,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$DomainNamingMaster,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$CrossForestReferences,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$Domains
    )

    if (-not(Get-ChildItem -Path Function:\Test-ADIActiveDirectoryModule -ErrorAction SilentlyContinue))
    {
        if (Test-ADIActiveDirectoryModule -eq $false)
        {
            Write-Error -Message "Please install the Active Directory PowerShell Module for your OS.
                                  You can install the PowerShell Module for Active Directory by yourself or
                                  run our Integraded CmdLet Install-ADIActiveDirectoryPowerShellModule."
            exit
        }
    }

    if ($PSBoundParameters.ContainsKey('ApplicationPartitions'))
    {
        $AllApplicationPartitions = New-Object -TypeName System.Collections.ArrayList
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $AllApplicationPartitions = (Get-ADForest -Identity $ForestName).ApplicationPartitions
            $class.GetApplicationPartitions($AllApplicationPartitions)
        }

        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $AllApplicationPartitions = (Get-ADForest -Server $ServerName -Identity $ForestName -Credential $Credential).ApplicationPartitions
                $class.GetApplicationPartitions($AllApplicationPartitions)
            }
            else
            {
                $AllApplicationPartitions = (Get-ADForest -Server $ServerName -Identity $ForestName).ApplicationPartitions
                $class.GetApplicationPartitions($AllApplicationPartitions)
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('DomainNamingMaster'))
    {
        $DomainNamingMasters = New-Object -TypeName System.Collections.ArrayList
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $DomainNamingMasters = (Get-ADForest -Identity $ForestName).DomainNamingMaster

            if ($DomainNamingMasters.Count -gt 1)
            {
                $class.GetDomainNamingMaster($DomainNamingMasters)
            }

            if ($DomainNamingMasters.Count -eq 1)
            {
                $class.GetDomainNamingMaster($DomainNamingMasters)
            }

            if ($DomainNamingMasters.Count -eq 0)
            {
                Write-Output 'No DomainNamingMasters in your Domain.'
            }
        }

        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $DomainNamingMasters = (Get-ADForest -Server $ServerName -Identity $ForestName -Credential $Credential).DomainNamingMaster

                if ($DomainNamingMasters.Count -gt 1)
                {
                    $class.GetDomainNamingMaster($DomainNamingMasters)
                }

                if ($DomainNamingMasters.Count -eq 1)
                {
                    $class.GetDomainNamingMaster($DomainNamingMasters)
                }

                if ($DomainNamingMasters.Count -eq 0)
                {
                    Write-Output 'No DomainNamingMasters in your Domain.'
                }
            }
            else
            {
                $DomainNamingMasters = (Get-ADForest -Server $ServerName -Identity $ForestName).DomainNamingMaster

                if ($DomainNamingMasters.Count -gt 1)
                {
                    $class.GetDomainNamingMaster($DomainNamingMasters)
                }

                if ($DomainNamingMasters.Count -eq 1)
                {
                    $class.GetDomainNamingMaster($DomainNamingMasters)
                }

                if ($DomainNamingMasters.Count -eq 0)
                {
                    Write-Output 'No DomainNamingMasters in your Domain.'
                }
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('CrossForestReferences'))
    {
        $ArrCrossForestReferences = New-Object -TypeName System.Collections.ArrayList
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $ArrCrossForestReferences = (Get-ADForest -Identity $ForestName).CrossForestReferences

            if ($ArrCrossForestReferences.Count -gt 1)
            {
                $class.GetCrossForestReferences($ArrCrossForestReferences)
            }

            if ($ArrCrossForestReferences.Count -eq 1)
            {
                $class.GetCrossForestReferences($ArrCrossForestReferences)
            }

            if ($ArrCrossForestReferences.Count -eq 0)
            {
                Write-Output 'No Trusts in your Domain.'
            }
        }

        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $ArrCrossForestReferences = (Get-ADForest -Server $ServerName -Identity $ForestName -Credential $Credential).CrossForestReferences

                if ($ArrCrossForestReferences.Count -gt 1)
                {
                    $class.GetCrossForestReferences($ArrCrossForestReferences)
                }

                if ($ArrCrossForestReferences.Count -eq 1)
                {
                    $class.GetCrossForestReferences($ArrCrossForestReferences)
                }

                if ($ArrCrossForestReferences.Count -eq 0)
                {
                    Write-Output 'No Trusts in your Domain.'
                }
            }
            else
            {
                $ArrCrossForestReferences = (Get-ADForest -Server $ServerName -Identity $ForestName).CrossForestReferences

                if ($ArrCrossForestReferences.Count -gt 1)
                {
                    $class.GetCrossForestReferences($ArrCrossForestReferences)
                }

                if ($ArrCrossForestReferences.Count -eq 1)
                {
                    $class.GetCrossForestReferences($ArrCrossForestReferences)
                }

                if ($ArrCrossForestReferences.Count -eq 0)
                {
                    Write-Output 'No Trusts in your Domain.'
                }
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('Domains'))
    {
        $ArrDomains = New-Object -TypeName System.Collections.ArrayList
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $ArrDomains = (Get-ADForest -Identity $ForestName).Domains

            if ($ArrDomains.Count -gt 1)
            {
                $class.GetDomains($ArrDomains)
            }

            if ($ArrDomains.Count -eq 1)
            {
                $class.GetDomains($ArrDomains)
            }

            if ($ArrDomains.Count -eq 0)
            {
                Write-Output 'Domains in your Domain'
            }
        }

        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $ArrDomains = (Get-ADForest -Server $ServerName -Identity $ForestName -Credential $Credential).Domains

                if ($ArrDomains.Count -gt 1)
                {
                    $class.GetDomains($ArrDomains)
                }

                if ($ArrDomains.Count -eq 1)
                {
                    $class.GetDomains($ArrDomains)
                }

                if ($ArrCrossForestReferences.Count -eq 0)
                {
                    Write-Output 'Domains in your Domain.'
                }
            }
            else
            {
                $ArrDomains = (Get-ADForest -Server $ServerName -Identity $ForestName).Domains

                if ($ArrDomains.Count -gt 1)
                {
                    $class.GetDomains($ArrDomains)
                }

                if ($ArrDomains.Count -eq 1)
                {
                    $class.GetDomains($ArrDomains)
                }

                if ($ArrDomains.Count -eq 0)
                {
                    Write-Output 'No Trusts in your Domain.'
                }
            }
        }
    }
}

# Export only the functions using PowerShell standard verb-noun naming.
Export-ModuleMember -Function *-*
