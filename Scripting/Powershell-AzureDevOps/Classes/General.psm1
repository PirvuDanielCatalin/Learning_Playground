$Global:Header
$Global:Organization
$Global:Project
$Global:ApiVersion

function Set-AuthenticationHeader {
    param
    (
        [Parameter(Mandatory = $true)] $Token
    )

    $BasicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f '', [string]$Token)))
    
    $Header = @{
        Authorization = "Basic " + $BasicAuth
    }

    $Global:Header = $Header
}

function Get-AuthenticationHeader {
    return $Global:Header
}

function Set-Organization {
    param
    (
        [Parameter(Mandatory = $true)] $Organization
    )
 
    $Global:Organization = [string] $Organization
}

function Get-Organization {
    return $Global:Organization
}

function Set-Project {
    param
    (
        [Parameter(Mandatory = $true)] $Project
    )
 
    $Global:Project = [string] $Project
}
 
function Get-Project {
    return $Global:Project
}

function Get-OrganizationAndProjectForURI {
    return $Global:Organization + "/" + $Global:Project
}

function Set-ApiVersion {
    param
    (
        [Parameter(Mandatory = $true)] $ApiVersion
    )

    $Global:ApiVersion = [string] $ApiVersion
}

function Get-ApiVersion {
    return $Global:ApiVersion
}