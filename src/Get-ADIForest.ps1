function Get-ADIForest
{
    [CmdletBinding(DefaultParameterSetName = 'DefaultParameters')]
    param
    (
        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [string]$ServerName = (Get-ADForest).DomainNamingMaster,

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
        [switch]$Domains,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$ForestMode,

        [Parameter(Mandatory = $false, ParameterSetName = 'AdditionalParameters')]
        [Parameter(Mandatory = $false, ParameterSetName = 'DefaultParameters')]
        [switch]$GlobalCatalogServers
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
                Write-Output 'No Domains in your Domain'
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
                    Write-Output 'No Domains in your Domain.'
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
                    Write-Output 'No Domains in your Domain.'
                }
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('ForestMode'))
    {
        if ($PSCmdlet.ParameterSetName -eq 'DefaultParameters')
        {
            $DomainForestMode = (Get-ADForest -Identity $ForestName).ForestMode.ToString()

            if (-not([String]::IsNullOrEmpty($DomainForestMode)))
            {
                $class.GetForestMode($DomainForestMode)
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
                $DomainForestMode = (Get-ADForest -Server $ServerName -Identity $ForestName -Credential $Credential).ForestMode.ToString()

                if (-not([String]::IsNullOrEmpty($DomainForestMode)))
                {
                    $class.GetForestMode($DomainForestMode)
                }

                if ([String]::IsNullOrEmpty($DomainForestMode))
                {
                    Write-Output 'No Forestmode in your Domain.'
                }
            }
            else
            {
                $DomainForestMode = (Get-ADForest -Server $ServerName -Identity $ForestName).ForestMode.ToString()

                if (-not([String]::IsNullOrEmpty($DomainForestMode)))
                {
                    $class.GetForestMode($DomainForestMode)
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
            $ArrGlobalCatalogServers = (Get-ADForest -Identity $ForestName).GlobalCatalogs

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

        if ($PSCmdlet.ParameterSetName -eq 'AdditionalParameters')
        {
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $ArrGlobalCatalogServers = (Get-ADForest -Server $ServerName -Identity $ForestName -Credential $Credential).GlobalCatalogs

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
                $ArrGlobalCatalogServers = (Get-ADForest -Server $ServerName -Identity $ForestName).GlobalCatalogs

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
    }

    if ($PSBoundParameters.Count -eq 0)
    {
        $class.ReturnOverview()
        #Write-Warning -Message 'No Parameters from my CmdLet specified. Return Results from Get-ADForest.'

        #Get-ADForest
    }
}