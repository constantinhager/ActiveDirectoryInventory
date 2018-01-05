---
external help file: ActiveDirectoryInventory-help.xml
Module Name: ActiveDirectoryInventory
online version:
schema: 2.0.0
---

# Get-ADIForest

## SYNOPSIS
Get Information about your Active Directory Forest

## SYNTAX

### DefaultParameters (Default)
```
Get-ADIForest [-ApplicationPartitions] [-DomainNamingMaster] [-CrossForestReferences] [-Domains] [-ForestMode]
 [-GlobalCatalogServers] [-ForestName] [-PartitionsContainer] [-RootDomain] [-SchemaMaster] [-Sites]
 [-SPNSuffixes] [-UPNSuffixes] [<CommonParameters>]
```

### AdditionalParameters
```
Get-ADIForest [-ServerName <String>] [-Credential <PSCredential>] [-ApplicationPartitions]
 [-DomainNamingMaster] [-CrossForestReferences] [-Domains] [-ForestMode] [-GlobalCatalogServers] [-ForestName]
 [-PartitionsContainer] [-RootDomain] [-SchemaMaster] [-Sites] [-SPNSuffixes] [-UPNSuffixes]
 [<CommonParameters>]
```

## DESCRIPTION
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

## EXAMPLES

### Example 1
```
PS C:\> Get-ADIForest
Returns all Information of the Domain in the current user context
```

### EXAMPLE 2
```
$cred = Get-Credential
Get-ADIForest -ServerName AD -Credential $cred
Returns all information of the Domain based on the credentials
```

### EXAMPLE 3
```
Get-ADIForest -ForestMode
Returns only the ForestMode in the current User context
```

### EXAMPLE 4
```
Get-ADIForest -ApplicationPartitions
Display all ApplicationPartitions as Objects in the current Domain
```

### Example 5
```
PS C:\> Get-ADIForest -ApplicationPartitions
```

Display all ApplicationPartitions as Objects in the current Domain

### Example 6
```
PS C:\> Get-ADIForest -ApplicationPartitions -ServerName DC
```

Display all ApplicationPartitions as Objects in the current Domain for the Server DC

### Example 7
```
PS C:\> Get-ADIForest -DomainNamingMaster
```

Display all DomainNamingMasters as Objects in the current Domain

### Example 8
```
PS C:\> Get-ADIForest -CrossForestReferences
```

Display all CrossForestReferences as Objects in the current Domain

### Example 9
```
PS C:\> Get-ADIForest -Domains
```

Display all Domains as Objects in the current Domain

## PARAMETERS

### -ServerName
One of the Active Directory Domain Controllers in the forest.

```yaml
Type: String
Parameter Sets: AdditionalParameters
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
If you do not have access with your current user you can supply credentials
for accessing the forest.

```yaml
Type: PSCredential
Parameter Sets: AdditionalParameters
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationPartitions
Switch to display All ApplicationPartitions as Objects.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainNamingMaster
Switch to display All DomainNamingMasters as Objects.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CrossForestReferences
Switch to display All CrossForestReferences as Objects.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Domains
Switch to display All Domains as Objects.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForestMode
Switch to display the Forest Mode

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GlobalCatalogServers
Switch to display all Global Catalog Servers as an Object.
Additionally you get the Site where the Global Catalog Server is in
and if he is reachable or not.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForestName
The name of the forest you would like to check

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PartitionsContainer
Switch to display the partitions container

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RootDomain
Switch to display the root domain

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SchemaMaster
Switch to display the schema master

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sites
Switch to display all sites

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SPNSuffixes
Switch to display all spnsuffixes

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UPNSuffixes
Switch to display all upnsuffixes

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### ActiveDirectoryInventory Object
### Overview Object

## NOTES
Author: Constantin Hager
Date: 02.11.2017

## RELATED LINKS

