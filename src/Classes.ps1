class Overview
{
    # Overview Properties
    [string]$DomainName
    [System.Collections.ArrayList]$Domains
    [System.Collections.ArrayList]$GlobalCatalogs
    [System.Collections.ArrayList]$ApplicationPartitions
    [System.Collections.ArrayList]$DomainNamingMaster
    [System.Collections.ArrayList]$CrossForestReference
    [System.Collections.ArrayList]$Sites
    [System.Collections.ArrayList]$SPNSuffixes
    [System.Collections.ArrayList]$UPNSuffixes
    [System.String]$ForestMode
    [string]$ForestName
    [string]$PartitionsContainer
    [string]$RootDomain
    [string]$SchemaMaster

    Overview()
    {
        $this.DomainName = [String]::Empty
        $this.Domains = New-Object -TypeName System.Collections.ArrayList
        $this.GlobalCatalogs = New-Object -TypeName System.Collections.ArrayList
        $this.ApplicationPartitions = New-Object -TypeName System.Collections.ArrayList
        $this.DomainNamingMaster = New-Object -TypeName System.Collections.ArrayList
        $this.CrossForestReference = New-Object -TypeName System.Collections.ArrayList
        $this.Sites = New-Object -TypeName System.Collections.ArrayList
        $this.UPNSuffixes = New-Object -TypeName System.Collections.ArrayList
        $this.SPNSuffixes = New-Object -TypeName System.Collections.ArrayList
        $this.ForestMode = [String]::Empty
        $this.ForestName = [String]::Empty
        $this.PartitionsContainer = [String]::Empty
        $this.RootDomain = [String]::Empty
        $this.SchemaMaster = [String]::Empty
    }

    [System.String] GetPartitionsContainer()
    {
        $RootDSE = New-Object -TypeName System.DirectoryServices.DirectoryEntry -ArgumentList "LDAP://RootDSE"
        $ConfigContainerArgument = ('LDAP://{0}' -f $RootDSE.Properties['configurationNamingContext'].Value)
        $ConfigContainer = New-Object -TypeName System.DirectoryServices.DirectoryEntry -ArgumentList $ConfigContainerArgument

        $ConfigSearcher = New-Object -TypeName System.DirectoryServices.DirectorySearcher -ArgumentList $ConfigContainer
        $ConfigSearcher.Filter = "(&(objectClass=crossRefContainer))"
        $ConfigSearcher.PropertiesToLoad.Add("distinguishedName")
        $ConfigSearcher.SearchScope = [System.DirectoryServices.SearchScope]::OneLevel

        [System.DirectoryServices.SearchResult]$SearchResult = $ConfigSearcher.FindOne()

        return $SearchResult.Properties["distinguishedName"][0].ToString()
    }

    [System.Collections.ArrayList] GetUPNSuffixes()
    {
        $UPNArray = New-Object -TypeName System.Collections.ArrayList
        $ID = 1

        $UPNDN = ('LDAP://{0}' -f $this.GetPartitionsContainer())

        $ADSIObject = [adsi]$UPNDN
        $UPNSuffixList = $ADSIObject | Select-Object -ExpandProperty upnsuffixes

        if ($UPNSuffixList -eq $null)
        {
            Write-Output -InputObject 'No UPN Suffixes are there'
            break
        }

        foreach ($UPNSuffix in $UPNSuffixList)
        {
            $row = [PSCustomObject]@{
                ID        = $ID
                UPNSuffix = $UPNSuffix
            }
            $UPNArray.Add($row)
            $ID++
        }

        return $UPNArray
    }

    [System.Collections.ArrayList] GetSPNSuffixes()
    {
        $SPNArr = New-Object -TypeName System.Collections.ArrayList
        $ID = 1

        $SPNSuffixList = (Get-ADForest).SPNSuffixes

        if ($SPNSuffixList -eq $null)
        {
            Write-Output -InputObject 'No SPN Suffixes'
            break
        }

        foreach ($SPNSuffix in $SPNSuffixList)
        {
            $row = [PSCustomObject]@{
                ID        = $ID
                SPNSuffix = $SPNSuffix
            }
            $SPNArr.Add($row)
            $ID++
        }

        return $SPNArr
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

    [bool] TestADIActiveDirectoryModule()
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

    [System.Collections.ArrayList] GetSites([System.Collections.ArrayList]$Sites)
    {
        $ArrSites = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        foreach ($Item in $Sites)
        {
            $row = [PSCustomObject]@{
                ID   = $this.ID
                Site = $Item
            }

            $null = $ArrSites.Add($row)
            $this.ID++
        }

        return $ArrSites
    }

    [System.Collections.ArrayList] GetSites([System.String]$Site)
    {
        $ArrSites = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        $row = [PSCustomObject]@{
            ID   = $this.ID
            Site = $Site
        }

        $null = $ArrSites.Add($row)
        return $ArrSites
    }

    [System.Collections.ArrayList] GetSPNSuffixes([System.Collections.ArrayList]$SPNSuffixes)
    {
        $ArrSPN = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        foreach ($Item in $SPNSuffixes)
        {
            $row = [PSCustomObject]@{
                ID  = $this.ID
                SPN = $Item
            }

            $null = $ArrSPN.Add($row)
            $this.ID++
        }

        return $ArrSPN
    }

    [System.Collections.ArrayList] GetSPNSuffixes([System.String]$SPN)
    {
        $ArrSPN = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        $row = [PSCustomObject]@{
            ID  = $this.ID
            SPN = $SPN
        }

        $null = $ArrSPN.Add($row)
        return $ArrSPN
    }

    [System.Collections.ArrayList] GetUPNSuffixes([System.Collections.ArrayList]$UPNSuffixes)
    {
        $ArrUPN = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        foreach ($Item in $UPNSuffixes)
        {
            $row = [PSCustomObject]@{
                ID  = $this.ID
                UPN = $Item
            }

            $null = $ArrUPN.Add($row)
            $this.ID++
        }

        return $ArrUPN
    }

    [System.Collections.ArrayList] GetUPNSuffixes([System.String]$UPN)
    {
        $ArrUPN = New-Object -TypeName System.Collections.ArrayList
        $this.ID = 1

        $row = [PSCustomObject]@{
            ID  = $this.ID
            UPN = $UPN
        }

        $null = $ArrUPN.Add($row)
        return $ArrUPN
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
        $overviewclass.ApplicationPartitions = $this.GetApplicationPartitions($ForestNetObject.ApplicationPartitions)
        $overviewclass.DomainNamingMaster = $this.GetDomainNamingMaster($ForestNetObject.NamingRoleOwner)
        $overviewclass.CrossForestReference = $this.GetCrossForestReferences($ForestNetObject.GetAllTrustRelationships())
        $overviewclass.ForestMode = $ForestNetObject.ForestMode
        $overviewclass.ForestName = $ForestNetObject.Name
        $overviewclass.PartitionsContainer = $overviewclass.GetPartitionsContainer()
        $overviewclass.RootDomain = $ForestNetObject.RootDomain
        $overviewclass.SchemaMaster = $ForestNetObject.SchemaRoleOwner
        $overviewclass.Sites = $this.GetSites($ForestNetObject.Sites)
        $overviewclass.UPNSuffixes = $overviewclass.GetUPNSuffixes()
        $overviewclass.SPNSuffixes = $overviewclass.GetSPNSuffixes()

        return $overviewclass
    }
}