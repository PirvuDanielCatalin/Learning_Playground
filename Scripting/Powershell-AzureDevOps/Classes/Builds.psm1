function Get-VstsBuildDefinition {
    param (
        [Parameter(Mandatory = $false)] $DefinitionID, # Uint64
        [Parameter(Mandatory = $false)] $Name, # String
        [Parameter(Mandatory = $false)] $RepositoryID, # String
        [Parameter(Mandatory = $false)] $Top, # Uint64
        [Parameter(Mandatory = $false)] $ApiVersion # String
    )
    
    $Uri = "https://dev.azure.com/"
    $Uri += Get-OrganizationAndProjectForURI
    $Uri += "/_apis/build/definitions"

    if ($null -ne $DefinitionID) {
        $DefinitionID = [uint64] $DefinitionID
        $Uri += "/" + $DefinitionID
    }

    $Uri += "?"

    if ($null -ne $DefinitionID) {
        $Filter = ''

        if ($null -ne $Name) {
            $Name = [string] $Name

            if ($Name.Trim() -ne "") {
                $Filter += 'name=' + $Name + '&'
            }
            else {
                throw "Parameter Name can't empty string!"
            }
        }

        if ($null -ne $RepositoryID) {
            $RepositoryID = [string] $RepositoryID

            if ($RepositoryID.Trim() -ne "") {
                $Filter += 'repositoryId=' + $RepositoryID + '&'
            }
            else {
                throw "Parameter RepositoryID can't empty string!"
            }
        }

        if ($null -ne $Top) {
            $Top = [uint64] $Top
            $Filter += '$top=' + $Top + '&'
        }

        $Uri += $Filter
    }
    else {
        $Uri += "propertyFilters=all&"
    }
    
    $Uri += "api-version="
    if ($null -ne $ApiVersion) {
        $ApiVersion = [string] $ApiVersion
        $Uri += $ApiVersion
    }
    else {
        $Uri += Get-ApiVersion
    }

    $BuildDefinitions = Invoke-RestMethod -Method Get -Uri $Uri -Headers (Get-AuthenticationHeader)
    return $BuildDefinitions
}

function Set-VstsBuildDefinition {
    param (
        [Parameter(Mandatory = $true)]  $DefinitionID, # String
        [Parameter(Mandatory = $true)]  $NewBody, # BuildDefinition
        [Parameter(Mandatory = $false)] $ApiVersion # String
    )

    $Uri = "https://dev.azure.com/"
    $Uri += Get-OrganizationAndProjectForURI
    $Uri += "/_apis/build/definitions/"

    $Uri += [int] $DefinitionID

    $Uri += "?api-version="
    if ($null -ne $ApiVersion) {
        $ApiVersion = [string] $ApiVersion
        $Uri += $ApiVersion
    }
    else {
        $Uri += Get-ApiVersion
    }

    Invoke-RestMethod -Method Put -Uri $Uri -Headers (Get-AuthenticationHeader) -Body $NewBody -ContentType "application/json"
}

function New-VstsBuildDefinition {
    param (
        [Parameter(Mandatory = $true)]  $Body, # BuildDefinition
        [Parameter(Mandatory = $false)] $ApiVersion # String
    )

    $Uri = "https://dev.azure.com/"
    $Uri += Get-OrganizationAndProjectForURI
    $Uri += "/_apis/build/definitions"

    $Uri += "?api-version="
    if ($null -ne $ApiVersion) {
        $ApiVersion = [string] $ApiVersion
        $Uri += $ApiVersion
    }
    else {
        $Uri += Get-ApiVersion
    }
    
    Invoke-RestMethod -Method Post -Uri $Uri -Headers (Get-AuthenticationHeader) -Body $Body -ContentType 'application/json'
}