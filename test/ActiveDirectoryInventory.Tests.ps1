[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope = '*', Target = 'SuppressImportModule')]
$SuppressImportModule = $true
. $PSScriptRoot\Shared.ps1

Describe 'Active Directory Module Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath
        $? | Should Be $true
    }
}


