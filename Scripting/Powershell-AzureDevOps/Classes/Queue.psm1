function Queue-BuildPipeline {
    param (
        [Parameter(Mandatory = $true)] $DefinitionID, # Uint64
        [Parameter(Mandatory = $false)] $ApiVersion # String
    )

    $Body = @{ 
        definition = @{
            id = $DefinitionID
        }
    }
    
    $Uri = "https://dev.azure.com/" 
    $Uri += Get-OrganizationAndProjectForURI
    $Uri += "/_apis/build/builds"

    $Uri += "?api-version="
    if ($null -ne $ApiVersion) {
        $ApiVersion = [string] $ApiVersion
        $Uri += $ApiVersion
    }
    else {
        $Uri += Get-ApiVersion
    }
    
    $Body = $Body | ConvertTo-Json -Depth 50
    Invoke-RestMethod -Method Post -Uri $Uri -Headers (Get-AuthenticationHeader) -Body $Body -ContentType "application/json"
}