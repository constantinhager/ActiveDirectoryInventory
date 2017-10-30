[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope = '*', Target = 'SuppressImportModule')]
$SuppressImportModule = $true
. $PSScriptRoot\Shared.ps1

Describe 'Test-ADIActiveDirectoryModule' {
    It 'PowerShell Module for ActiveDirectory should be installed' {
        Test-ADIActiveDirectoryModule | Should Be $true
    }
}