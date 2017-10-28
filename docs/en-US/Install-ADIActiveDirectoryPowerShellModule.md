---
external help file: ActiveDirectoryInventory-help.xml
Module Name: ActiveDirectoryInventory
online version: 
schema: 2.0.0
---

# Install-ADIActiveDirectoryPowerShellModule

## SYNOPSIS
Installes the PowerShell Module for Active Directory

## SYNTAX

### ServerOS
```
Install-ADIActiveDirectoryPowerShellModule [-IsWindowsServer] [<CommonParameters>]
```

### ClientOS
```
Install-ADIActiveDirectoryPowerShellModule -InstallURL <String> -DownloadPath <String> [<CommonParameters>]
```

## DESCRIPTION
Installes the PowerShell Module for Active Directory.

If you are on a Windows Server you do not need to provide a URL.
The function will use Install-WindowsFeature.

If you are on a Client OS you have to provide the URL to the MSU file
for the RSAT Tools and a Download location.

The routine will check if the URL that you provided contains thestring msu.
If it does not then the function will return an error and exit.

After that It will check if the downloadlocation where the MSU-Filewill be downloaded
to exist.

If It does not exist the function will return an error and exit.
If the download location exists the function tries to download the MSU-File from the
URL that you provided to the Downloadlocation that you provided.

If the download was successful the installation of the RSAT toolsstarts immediately
and waits for It till It is finished.

## EXAMPLES

### Example 1
```
PS C:\> $param_download = @{
        InstallURL = 'https://download.microsoft.com/download/1/D/8/1D8B5022-5477-4B9A-8104-6A71FF9D98AB/WindowsTH-RSAT_WS_1709-x64.msu'
        DownloadPath = 'C:\Temp\'
    }
    Install-ADIActiveDirectoryPowerShellModule @param_download
```

Downloads the RSAT-Tools from the URL https://download.microsoft.com/download/1/D/8/1D8B5022-5477-4B9A-8104-6A71FF9D98AB/WindowsTH-RSAT_WS_1709-x64.msu
    and downloads It to C:\Temp and installs It afterwards

### Example 2
```
PS C:\> Install-ADIActiveDirectoryPowerShellModule -IsWindowsServer
    Installs the PowerShell Module for ActiveDirectory on a Windows Server
```

Installs the PowerShell Module for ActiveDirectory on a Windows Server

## PARAMETERS

### -IsWindowsServer
If you provide this Parameter you tell the function that you are on a Windows Server.
    You do not have to provide a InstallURL or a DownloadPath.

```yaml
Type: SwitchParameter
Parameter Sets: ServerOS
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstallURL
The URL where the MSU-File for the RSAT Tools can be downloaded.
    Example: https://download.microsoft.com/download/1/D/8/1D8B5022-5477-4B9A-8104-6A71FF9D98AB/WindowsTH-RSAT_WS_1709-x64.msu

```yaml
Type: String
Parameter Sets: ClientOS
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DownloadPath
The Path where the MSU-File for RSAT-Tools will be stored.

```yaml
Type: String
Parameter Sets: ClientOS
Aliases: 

Required: True
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
Date: 28.10.2017

## RELATED LINKS

