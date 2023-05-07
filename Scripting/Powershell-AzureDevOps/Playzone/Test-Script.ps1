Import-Module $PSScriptRoot\Test-Library.psm1
Get-Test
Set-Test
Get-Test
Set-Test -Ceva "Custom"
Get-Test

$Test = "FromOutside"
Get-Test

Get-Variable Test