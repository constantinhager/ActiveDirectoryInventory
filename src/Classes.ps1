class Overview
{
    # Overview Properties
    [string]$DomainName
    [System.Collections.ArrayList]$Domains
    [System.Collections.ArrayList]$GlobalCatalogs

    Overview()
    {
        $this.DomainName = [String]::Empty
        $this.Domains = New-Object -TypeName System.Collections.ArrayList
        $this.GlobalCatalogs = New-Object -TypeName System.Collections.ArrayList
    }
}

class ActiveDirectoryInventoryClass
{
    # Count Variable
    [int]$ID

    # Global Catalog Properties
    [string]$GlobalCatalogServerSiteName
    [bool]$IsGlobalCatalogReachable

    ActiveDirectoryInventoryClass()
    {
        $this.ID = 0
        $this.GlobalCatalogServerSiteName = [String]::Empty
        $this.IsGlobalCatalogReachable = $false
    }

    [bool]TestADIActiveDirectoryModule()
    {
        if ([String]::IsNullOrEmpty(((Get-Module -ListAvailable).Where{$_.Name -eq 'ActiveDirectory'}).Name))
        {
            return $true
        }
        else
        {
            return $false
        }
    }

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
        $DomainNaimingMaster = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        $row = [PSCustomObject]@{
            ID                 = $this.ID
            DomainNamingMaster = $SingleDomainNamingMaster
        }

        $null = $DomainNaimingMaster.Add($row)
        return $DomainNaimingMaster
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

        $null = $ArrCrossForestReference.Add($row)
        return $ArrCrossForestReference
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

    [System.Collections.ArrayList] GetForestMode([System.String]$ForestMode)
    {
        $ArrForestMode = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        $row = [PSCustomObject]@{
            ID         = $this.ID
            ForestMode = $ForestMode
        }

        $null = $ArrForestMode.Add($row)
        return $ArrForestMode
    }

    [System.Collections.ArrayList] GetGlobalCatalogServers([System.Collections.ArrayList]$GlobalCatalogServers)
    {
        $ArrGlobalCatalogServers = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        foreach ($Item in $GlobalCatalogServers)
        {
            if ($item -is [System.DirectoryServices.ActiveDirectory.GlobalCatalog])
            {
                if (Test-Connection -ComputerName $Item.Name -Count 1 -Quiet)
                {
                    $this.IsGlobalCatalogReachable = $true
                    $this.GlobalCatalogServerSiteName = (Get-ADDomainController -Identity $Item.Name).Site
                }
                else
                {
                    $this.IsGlobalCatalogReachable = $false
                    $this.GlobalCatalogServerSiteName = 'NO SITENAME'
                }
            }
            else
            {
                if (Test-Connection -ComputerName $Item -Count 1 -Quiet)
                {
                    $this.IsGlobalCatalogReachable = $true
                    $this.GlobalCatalogServerSiteName = (Get-ADDomainController -Identity $Item).Site
                }
                else
                {
                    $this.IsGlobalCatalogReachable = $false
                    $this.GlobalCatalogServerSiteName = ''
                }
            }



            $row = [PSCustomObject]@{
                ID                  = $this.ID
                GlobalCatalogServer = $Item
                IsReachable         = $this.IsGlobalCatalogReachable
                SiteName            = $this.GlobalCatalogServerSiteName
            }

            $null = $ArrGlobalCatalogServers.Add($row)
            $this.ID++
        }

        return $ArrGlobalCatalogServers
    }

    [System.Collections.ArrayList] GetGlobalCatalogServers([System.String]$GloblalCatalogServers)
    {
        $ArrGlobalCatalogServers = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        if (Test-Connection -ComputerName $GloblalCatalogServers -Count 1 -Quiet)
        {
            $this.IsGlobalCatalogReachable = $true
            $this.GlobalCatalogServerSiteName = (Get-ADDomainController -Identity $GloblalCatalogServers).Site
        }
        else
        {
            $this.IsGlobalCatalogReachable = $false
            $this.GlobalCatalogServerSiteName = ''
        }

        $row = [PSCustomObject]@{
            ID                  = $this.ID
            GlobalCatalogServer = $GloblalCatalogServers
            IsReachable         = $this.IsGlobalCatalogReachable
            SiteName            = $this.GlobalCatalogServerSiteName
        }

        $null = $ArrGlobalCatalogServers.Add($row)
        return $ArrGlobalCatalogServers
    }

    [Overview]ReturnOverview()
    {
        $ForestNetObject = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()

        # returnObject
        #Name                  :
        #Sites                 :
        #Domains               :
        #GlobalCatalogs        :
        #ApplicationPartitions :
        #ForestModeLevel       :
        #ForestMode            :
        #RootDomain            :
        #Schema                :
        #SchemaRoleOwner       :
        #NamingRoleOwner       :

        $overviewclass = New-Object -TypeName Overview

        $overviewclass.DomainName = $ForestNetObject.Name
        $overviewclass.Domains = $this.GetDomains($ForestNetObject.Domains)
        $overviewclass.GlobalCatalogs = $this.GetGlobalCatalogServers($ForestNetObject.GlobalCatalogs)

        return $overviewclass
    }
}