# Implement your module commands in this script.
# Prefix = ADI

# Dot Source Classes.ps1
. $PSScriptRoot\Classes.ps1

#Instanciate Class
$class = New-Object -TypeName ActiveDirectoryInventoryClass

# Dot Source Install-ADIActiveDirectoryPowerShellModule.ps1
. $PSScriptRoot\Install-ADIActiveDirectoryPowerShellModule.ps1

# Dot Source Get-ADIForest
. $PSScriptRoot\Get-ADIForest.ps1

# Export only the functions using PowerShell standard verb-noun naming.
Export-ModuleMember -Function *-*