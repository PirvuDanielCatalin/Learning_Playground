function Get-VstsGitRepositories {
    param (
        [Parameter(Mandatory = $false)] $RepositoryId, # String
        [Parameter(Mandatory = $false)] $ApiVersion # String
    )

    $Uri = "https://dev.azure.com/"
    $Uri += Get-OrganizationAndProjectForURI
    $Uri += "/_apis/git/repositories"

    if ($null -ne $RepositoryId) {
        $RepositoryId = [string] $RepositoryId
        $Uri += "/" + $RepositoryId
    } 

    $Uri += "api-version="
    if ($null -ne $ApiVersion) {
        $ApiVersion = [string] $ApiVersion
        $Uri += $ApiVersion
    }
    else {
        $Uri += Get-ApiVersion
    }

    $Repositories = Invoke-RestMethod -Method Get -Uri $Uri -Headers (Get-AuthenticationHeader)
    return $Repositories;
}