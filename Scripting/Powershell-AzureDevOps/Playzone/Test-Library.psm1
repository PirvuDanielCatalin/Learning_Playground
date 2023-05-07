$Global:Test = "Initial"

function Get-Test {
    return $Global:Test
}

function Set-Test {
    param
    (
        [Parameter(Mandatory = $false)] [string]$Ceva = 'Default'
    )
    $Global:Test = $Ceva;
}

Export-ModuleMember -Function 'Get-*'
Export-ModuleMember -Function 'Set-*'