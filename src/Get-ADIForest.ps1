function Get-ADIForest
{
    [CmdletBinding(DefaultParameterSetName = 'DefaultParameters')]
    param
    (
        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [string]$ServerName = (Get-ADForest).DomainNamingMaster,

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
            Write-Error -Message "Please install the Active Directory PowerShell Module for your OS.
                                  You can install the PowerShell Module for Active Directory by yourself or
                                  run our Integraded CmdLet Install-ADIActiveDirectoryPowerShellModule."
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
                Write-Output 'No DomainNamingMasters in your Domain.'
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
                Write-Output 'No Trusts in your Domain.'
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
                    Write-Output 'No Trusts in your Domain.'
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
                Write-Output 'No Domains in your Domain'
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
                    Write-Output 'No Domains in your Domain.'
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
                    Write-Output 'No Domains in your Domain.'
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
                Write-Output 'No Forestmode in your Domain.'
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
                    Write-Output 'No Forestmode in your Domain.'
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
                    Write-Output 'No Forestmode in your Domain.'
                }
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('GlobalCatalogServers'))
    {
        $ArrGlobalCatalogServers = New-Object -TypeName System.Collections.ArrayList
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $ArrGlobalCatalogServers = (Get-ADForest -Identity $NameOfForest).GlobalCatalogs

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
                Write-Output 'No Trusts in your Domain.'
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
                Write-Output 'No Domains in your Domain'
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
                    Write-Output 'No Sites in your Domain.'
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
                    Write-Output 'No Sites in your Domain.'
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
                Write-Output 'No Domains in your Domain'
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
                    Write-Output 'No Sites in your Domain.'
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
                    Write-Output 'No Sites in your Domain.'
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
                Write-Output 'No Domains in your Domain'
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
                    Write-Output 'No Sites in your Domain.'
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
                    Write-Output 'No Sites in your Domain.'
                }
            }
        }
    }

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
                Write-Output 'No Trusts in your Domain.'
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
                Write-Output 'No Trusts in your Domain.'
            }
        }
    }

    if ($PSBoundParameters.Count -eq 0)
    {
        Write-Warning -Message 'No Parameters from my CmdLet specified. Return Results from my internal Class.'
        $class.ReturnOverview()
    }
}