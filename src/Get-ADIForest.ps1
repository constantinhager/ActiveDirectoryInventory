function Get-ADIForest
{
    <#
    .SYNOPSIS
    Returns the ActiveDirectory Forest Information in form of objects.

    .DESCRIPTION
    This Functions returns Active Directory forest information as Objects.
    You can return the following as objects:
    - All Application Partitions
    - All CrossForestReferences
    - All DomainNamingMasters
    - All Domains
    - The Forest Mode
    - All Global Catalog Servers
        - SiteName of Global Catalog Servers
        - Is the Global Catalog Server reachable?
    - The DomainName
    - All Sites
    - All SPNSuffixes
    - All UPNSuffixes
    - The ForestName
    - The PartitionsContainer
    - The Name of the RootDomain
    - The SchemaMaster

    .PARAMETER ServerName
    The Name of a Domain Controller

    .PARAMETER Credential
    A Credential that has access to Domain information

    .PARAMETER ApplicationPartitions
    Gets only the Application Partitions.

    .PARAMETER DomainNamingMaster
    Gets only the DomainNamingMaster

    .PARAMETER CrossForestReferences
    Gets only the CrossForestReferences

    .PARAMETER Domains
    Gets only the Domains

    .PARAMETER ForestMode
    Gets only the ForestMode

    .PARAMETER GlobalCatalogServers
    Gets only the GlobalCatalogServers

    .PARAMETER ForestName
    Gets only the ForestName

    .PARAMETER PartitionsContainer
    Gets only the PartitionsContainer

    .PARAMETER RootDomain
    Gets only the RootDomain

    .PARAMETER SchemaMaster
    Gets only the SchemaMaster

    .PARAMETER Sites
    Gets only the Sites in the ActiveDirectory

    .PARAMETER SPNSuffixes
    Gets only the SPNSuffixes

    .PARAMETER UPNSuffixes
    Gets only the UPNSuffixes

    .EXAMPLE
    Get-ADIForest
    Returns all Information of the Domain in the current user context

    .EXAMPLE
    $cred = Get-Credential
    Get-ADIForest -ServerName AD -Credential $cred
    Returns all information of the Domain based on the credentials

    .EXAMPLE
    Get-ADIForest -ForestMode
    Returns only the ForestMode in the current User context

    .EXAMPLE
    Get-ADIForest -ApplicationPartitions
    Display all ApplicationPartitions as Objects in the current Domain

    .EXAMPLE
    Get-ADIForest -ApplicationPartitions -ServerName DC
    Display all ApplicationPartitions as Objects in the current Domain for the Server DC

    .EXAMPLE
    Get-ADIForest -DomainNamingMaster
    Display all DomainNamingMasters as Objects in the current Domain

    .EXAMPLE
    Get-ADIForest -CrossForestReferences
    Display all CrossForestReferences as Objects in the current Domain

    .EXAMPLE
    Get-ADIForest -Domains
    Display all Domains as Objects in the current Domain

    .NOTES
    Author: Constantin Hager
    Date: 05.01.2018
    #>

    [CmdletBinding(DefaultParameterSetName = 'DefaultParameters')]
    param
    (
        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [string]$ServerName,

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
        [switch]$Domains,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$ForestMode,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$GlobalCatalogServers,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$ForestName,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$PartitionsContainer,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$RootDomain,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$SchemaMaster,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$Sites,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$SPNSuffixes,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$UPNSuffixes
    )

    if (-not(Get-ChildItem -Path Function:\Test-ADIActiveDirectoryModule -ErrorAction SilentlyContinue))
    {
        if (($class.TestADIActiveDirectoryModule()) -eq $true)
        {
            Write-Error -Message 'Please install the Active Directory PowerShell Module for your OS.
                                  You can install the PowerShell Module for Active Directory by yourself or
                                  run our Integraded CmdLet Install-ADIActiveDirectoryPowerShellModule.'
            exit
        }
    }

    $NameOfForest = (Get-ADForest).Name

    if ($PSBoundParameters.ContainsKey('ApplicationPartitions'))
    {
        $AllApplicationPartitions = New-Object -TypeName System.Collections.ArrayList
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $AllApplicationPartitions = (Get-ADForest -Identity $NameOfForest).ApplicationPartitions
            $class.GetApplicationPartitions($AllApplicationPartitions)
        }

        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $AllApplicationPartitions = (Get-ADForest -Server $ServerName -Identity $NameOfForest -Credential $Credential).ApplicationPartitions
                $class.GetApplicationPartitions($AllApplicationPartitions)
            }
            else
            {
                $AllApplicationPartitions = (Get-ADForest -Server $ServerName -Identity $NameOfForest).ApplicationPartitions
                $class.GetApplicationPartitions($AllApplicationPartitions)
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('DomainNamingMaster'))
    {
        $DomainNamingMasters = New-Object -TypeName System.Collections.ArrayList
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $DomainNamingMasters = (Get-ADForest -Identity $NameOfForest).DomainNamingMaster

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
                Write-Output -InputObject 'No DomainNamingMasters in your Domain.'
            }
        }

        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $DomainNamingMasters = (Get-ADForest -Server $ServerName -Identity $NameOfForest -Credential $Credential).DomainNamingMaster

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
                    Write-Output -InputObject 'No DomainNamingMasters in your Domain.'
                }
            }
            else
            {
                $DomainNamingMasters = (Get-ADForest -Server $ServerName -Identity $NameOfForest).DomainNamingMaster

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
                    Write-Output -InputObject 'No DomainNamingMasters in your Domain.'
                }
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('CrossForestReferences'))
    {
        $ArrCrossForestReferences = New-Object -TypeName System.Collections.ArrayList
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $ArrCrossForestReferences = (Get-ADForest -Identity $NameOfForest).CrossForestReferences

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
                Write-Output -InputObject 'No Trusts in your Domain.'
            }
        }

        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $ArrCrossForestReferences = (Get-ADForest -Server $ServerName -Identity $NameOfForest -Credential $Credential).CrossForestReferences

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
                    Write-Output -InputObject 'No Trusts in your Domain.'
                }
            }
            else
            {
                $ArrCrossForestReferences = (Get-ADForest -Server $ServerName -Identity $NameOfForest).CrossForestReferences

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
                    Write-Output -InputObject 'No Trusts in your Domain.'
                }
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('Domains'))
    {
        $ArrDomains = New-Object -TypeName System.Collections.ArrayList
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $ArrDomains = (Get-ADForest -Identity $NameOfForest).Domains

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
                Write-Output -InputObject 'No Domains in your Domain'
            }
        }

        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $ArrDomains = (Get-ADForest -Server $ServerName -Identity $NameOfForest -Credential $Credential).Domains

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
                    Write-Output -InputObject 'No Domains in your Domain.'
                }
            }
            else
            {
                $ArrDomains = (Get-ADForest -Server $ServerName -Identity $NameOfForest).Domains

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
                    Write-Output -InputObject 'No Domains in your Domain.'
                }
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('ForestMode'))
    {
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $DomainForestMode = (Get-ADForest -Identity $NameOfForest).ForestMode.ToString()

            if (-not([String]::IsNullOrEmpty($DomainForestMode)))
            {
                $DomainForestMode
            }

            if ([String]::IsNullOrEmpty($DomainForestMode))
            {
                Write-Output -InputObject 'No Forestmode in your Domain.'
            }
        }

        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $DomainForestMode = (Get-ADForest -Server $ServerName -Identity $NameOfForest -Credential $Credential).ForestMode.ToString()

                if (-not([String]::IsNullOrEmpty($DomainForestMode)))
                {
                    $DomainForestMode
                }

                if ([String]::IsNullOrEmpty($DomainForestMode))
                {
                    Write-Output -InputObject 'No Forestmode in your Domain.'
                }
            }
            else
            {
                $DomainForestMode = (Get-ADForest -Server $ServerName -Identity $NameOfForest).ForestMode.ToString()

                if (-not([String]::IsNullOrEmpty($DomainForestMode)))
                {
                    $DomainForestMode
                }

                if ([String]::IsNullOrEmpty($DomainForestMode))
                {
                    Write-Output -InputObject 'No Forestmode in your Domain.'
                }
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('GlobalCatalogServers'))
    {
        $ArrGlobalCatalogServers = New-Object -TypeName System.Collections.ArrayList
        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $ArrGlobalCatalogServers = (Get-ADForest -Server $ServerName -Identity $NameOfForest -Credential $Credential).GlobalCatalogs

                if ($ArrGlobalCatalogServers.Count -gt 1)
                {
                    $class.GetGlobalCatalogServers($ArrGlobalCatalogServers)
                }

                if ($ArrGlobalCatalogServers.Count -eq 1)
                {
                    $class.GetGlobalCatalogServers($ArrGlobalCatalogServers)
                }

                if ($ArrGlobalCatalogServers.Count -eq 0)
                {
                    Write-Output -InputObject 'No Trusts in your Domain.'
                }
            }
            else
            {
                $ArrGlobalCatalogServers = (Get-ADForest -Server $ServerName -Identity $NameOfForest).GlobalCatalogs

                if ($ArrGlobalCatalogServers.Count -gt 1)
                {
                    $class.GetGlobalCatalogServers($ArrGlobalCatalogServers)
                }

                if ($ArrGlobalCatalogServers.Count -eq 1)
                {
                    $class.GetGlobalCatalogServers($ArrGlobalCatalogServers)
                }

                if ($ArrGlobalCatalogServers.Count -eq 0)
                {
                    Write-Output -InputObject 'No Trusts in your Domain.'
                }
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('ForestName'))
    {
        (Get-ADForest).Name
    }

    if ($PSBoundParameters.ContainsKey('PartitionsContainer'))
    {
        (Get-ADForest).PartitionsContainer
    }

    if ($PSBoundParameters.ContainsKey('RootDomain'))
    {
        (Get-ADForest).RootDomain
    }

    if ($PSBoundParameters.ContainsKey('SchemaMaster'))
    {
        (Get-ADForest).SchemaMaster
    }

    if ($PSBoundParameters.ContainsKey('Sites'))
    {
        $ArrSites = New-Object -TypeName System.Collections.ArrayList
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $ArrSites = (Get-ADForest -Identity $NameOfForest).Sites

            if ($ArrSites.Count -gt 1)
            {
                $class.GetSites($ArrSites)
            }

            if ($ArrSites.Count -eq 1)
            {
                $class.GetSites($ArrSites)
            }

            if ($ArrSites.Count -eq 0)
            {
                Write-Output -InputObject 'No Domains in your Domain'
            }
        }

        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $ArrSites = (Get-ADForest -Server $ServerName -Identity $NameOfForest -Credential $Credential).Sites

                if ($ArrSites.Count -gt 1)
                {
                    $class.GetSites($ArrSites)
                }

                if ($ArrSites.Count -eq 1)
                {
                    $class.GetSites($ArrSites)
                }

                if ($ArrSites.Count -eq 0)
                {
                    Write-Output -InputObject 'No Sites in your Domain.'
                }
            }
            else
            {
                $ArrSites = (Get-ADForest -Server $ServerName -Identity $NameOfForest).Domains

                if ($ArrSites.Count -gt 1)
                {
                    $class.GetSites($ArrSites)
                }

                if ($ArrSites.Count -eq 1)
                {
                    $class.GetSites($ArrSites)
                }

                if ($ArrSites.Count -eq 0)
                {
                    Write-Output -InputObject 'No Sites in your Domain.'
                }
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('SPNSuffixes'))
    {
        $ArrSPN = New-Object -TypeName System.Collections.ArrayList
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $ArrSPN = (Get-ADForest -Identity $NameOfForest).SPNSuffixes

            if ($ArrSPN.Count -gt 1)
            {
                $class.GetSPNSuffixes($ArrSPN)
            }

            if ($ArrSPN.Count -eq 1)
            {
                $class.GetSPNSuffixes($ArrSPN)
            }

            if ($ArrSPN.Count -eq 0)
            {
                Write-Output -InputObject 'No Domains in your Domain'
            }
        }

        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $ArrSPN = (Get-ADForest -Server $ServerName -Identity $NameOfForest -Credential $Credential).SPNSuffixes

                if ($ArrSPN.Count -gt 1)
                {
                    $class.GetSPNSuffixes($ArrSPN)
                }

                if ($ArrSPN.Count -eq 1)
                {
                    $class.GetSPNSuffixes($ArrSPN)
                }

                if ($ArrSPN.Count -eq 0)
                {
                    Write-Output -InputObject 'No Sites in your Domain.'
                }
            }
            else
            {
                $ArrSPN = (Get-ADForest -Server $ServerName -Identity $NameOfForest).SPNSuffixes

                if ($ArrSPN.Count -gt 1)
                {
                    $class.GetSPNSuffixes($ArrSPN)
                }

                if ($ArrSPN.Count -eq 1)
                {
                    $class.GetSPNSuffixes($ArrSPN)
                }

                if ($ArrSPN.Count -eq 0)
                {
                    Write-Output -InputObject 'No Sites in your Domain.'
                }
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('UPNSuffixes'))
    {
        $ArrUPN = New-Object -TypeName System.Collections.ArrayList
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $ArrUPN = (Get-ADForest -Identity $NameOfForest).UPNSuffixes

            if ($ArrUPN.Count -gt 1)
            {
                $class.GetUPNSuffixes($ArrUPN)
            }

            if ($ArrUPN.Count -eq 1)
            {
                $class.GetUPNSuffixes($ArrUPN)
            }

            if ($ArrUPN.Count -eq 0)
            {
                Write-Output -InputObject 'No Domains in your Domain'
            }
        }

        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $ArrUPN = (Get-ADForest -Server $ServerName -Identity $NameOfForest -Credential $Credential).UPNNSuffixes

                if ($ArrUPN.Count -gt 1)
                {
                    $class.GetUPNSuffixes($ArrUPN)
                }

                if ($ArrUPN.Count -eq 1)
                {
                    $class.GetUPNSuffixes($ArrUPN)
                }

                if ($ArrUPN.Count -eq 0)
                {
                    Write-Output -InputObject 'No Sites in your Domain.'
                }
            }
            else
            {
                $ArrUPN = (Get-ADForest -Server $ServerName -Identity $NameOfForest).SPNSuffixes

                if ($ArrUPN.Count -gt 1)
                {
                    $class.GetUPNSuffixes($ArrUPN)
                }

                if ($ArrUPN.Count -eq 1)
                {
                    $class.GetUPNSuffixes($ArrUPN)
                }

                if ($ArrUPN.Count -eq 0)
                {
                    Write-Output -InputObject 'No Sites in your Domain.'
                }
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('ServerName'))
    {
        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                Write-Warning -Message 'No Parameters from my CmdLet specified. Return Results from my internal Class.'
                $overview.ReturnOverviewWithCredentials($Credential)
            }
            else
            {
                Write-Warning -Message 'No Parameters from my CmdLet specified. Return Results from my internal Class.'
                $overview.ReturnOverview()
            }
        }
    }

    if ($PSBoundParameters.Count -eq 0)
    {
        Write-Warning -Message 'No Parameters from my CmdLet specified. Return Results from my internal Class.'
        $overview.ReturnOverview()
    }
}