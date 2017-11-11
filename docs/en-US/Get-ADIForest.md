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
 [-GlobalCatalogServers] [<CommonParameters>]
```

### AdditionalParameters
```
Get-ADIForest [-ServerName <String>] [-ForestName <String>] [-Credential <PSCredential>]
 [-ApplicationPartitions] [-DomainNamingMaster] [-CrossForestReferences] [-Domains] [-ForestMode]
 [-GlobalCatalogServers] [<CommonParameters>]
```

## DESCRIPTION
This Functions returns Active Directory forest information as Objects.
You can return the following as objects:
- All Application Partitions
- All CrossForestReferences
- All DomainNamingMasters
- All Domains

## EXAMPLES

### Example 1
```
PS C:\> Get-ADIForest -ApplicationPartitions
```

Display all ApplicationPartitions as Objects in the current Domain

### Example 2
```
PS C:\> Get-ADIForest -ApplicationPartitions -ServerName DC
```

Display all ApplicationPartitions as Objects in the current Domain for the Server DC

### Example 3
```
PS C:\> Get-ADIForest -DomainNamingMaster
```

Display all DomainNamingMasters as Objects in the current Domain

### Example 4
```
PS C:\> Get-ADIForest -CrossForestReferences
```

Display all CrossForestReferences as Objects in the current Domain

### Example 5
```
PS C:\> Get-ADIForest -Domains
```

Display all Domains as Objects in the current Domain

## PARAMETERS

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
{{Fill ForestMode Description}}

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
Type: String
Parameter Sets: AdditionalParameters
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GlobalCatalogServers
{{Fill GlobalCatalogServers Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES
Author: Constantin Hager
Date: 02.11.2017

## RELATED LINKS

