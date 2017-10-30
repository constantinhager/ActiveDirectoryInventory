[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope = '*', Target = 'SuppressImportModule')]
$SuppressImportModule = $true
. $PSScriptRoot\Shared.ps1

Describe 'Install-ADIActiveDirectoryPowerShellModule' {
    It 'Runs on Server 2016' {
        Mock -CommandName Get-CimInstance -ParameterFilter {$ClassName -eq 'Win32_OperatingSystem'} -MockWith {
            return [PSCustomObject]@{
                Name = 'Microsoft Windows Server 2016'
            }
        }

        Mock -CommandName Add-WindowsFeature -MockWith {}

        $retval = Install-ADIActiveDirectoryPowerShellModule -IsWindowsServer
        $retval | Should Be $null
    }

    It 'Runs on Client OS' {
        $InstallURL = 'https://download.microsoft.com/download/1/D/8/1D8B5022-5477-4B9A-8104-6A71FF9D98AB/WindowsTH-RSAT_WS_1709-x64.msu'
        $DownloadPath = "TestDrive:\"
        $FileName = "rsat.msu"
        $FullName = Join-Path -Path $DownloadPath -ChildPath $FileName

        $retval = Install-ADIActiveDirectoryPowerShellModule -InstallURL $InstallURL -DownloadPath $DownloadPath
        $retval | Should Be $null
    }
}