function Get-VstsReleaseDefinition {
    param (
        [Parameter(Mandatory = $false)] $DefinitionID, # Uint64
        [Parameter(Mandatory = $false)] $ApiVersion # String
    )

    $Uri = "https://vsrm.dev.azure.com/"  
    $Uri += Get-OrganizationAndProjectForURI
    $Uri += "/_apis/release/definitions/"

    if ($null -ne $DefinitionID) {
        $DefinitionID = [uint64] $DefinitionID
        $Uri += "/" + $DefinitionID
    }

    $Uri += "?"

    if ($null -eq $DefinitionID) {
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

    $ReleaseDefinition = Invoke-RestMethod -Method Get -Uri $Uri -Headers (Get-AuthenticationHeader)
    return $ReleaseDefinition
}

function Get-VstsReleaseDefinitionStage {
    param (
        [Parameter(Mandatory = $true)] $DefinitionID, # Uint64
        [Parameter(Mandatory = $true)] $StageID, # Uint64
        [Parameter(Mandatory = $false)] $ApiVersion # String
    )

    $ReleaseDefinition = Get-VstsReleaseDefinition -DefinitionID $DefinitionID -ApiVersion $ApiVersion

    $StageReturned = $null
    foreach ($Stage in $ReleaseDefinition.environments) {
        if ($Stage.id -eq $StageID) {
            $StageReturned = $Stage
            break
        }
    }

    return $StageReturned
}

function Set-VstsReleaseDefinition() {
    param (
        [Parameter(Mandatory = $true)]  $DefinitionID, # String
        [Parameter(Mandatory = $true)]  $NewBody, # ReleaseDefinition
        [Parameter(Mandatory = $false)] $ApiVersion # String
    )

    $Uri = "https://vsrm.dev.azure.com/"
    $Uri += Get-OrganizationAndProjectForURI
    $Uri += "/_apis/release/definitions/"

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

function New-VstsReleaseDefinitionStage() {
    param (
        [Parameter(Mandatory = $true)] $DefinitionID, # Uint64
        [Parameter(Mandatory = $true)] $NewStage, # ReleaseEnvironment
        [Parameter(Mandatory = $false)] $ApiVersion # String
    )

    $ReleaseDefinition = Get-VstsReleaseDefinition -DefinitionID $DefinitionID -ApiVersion $ApiVersion

    $ReleaseEnvironments = [System.Collections.ArrayList] $ReleaseDefinition.environments
    $ReleaseEnvironments.Add($NewStage) | Out-Null
    $ReleaseDefinition.environments = $ReleaseEnvironments

    $ReleaseDefinition = $ReleaseDefinition | ConvertTo-Json -Depth 50
    Set-VstsReleaseDefinition -DefinitionID $DefinitionID -NewBody $ReleaseDefinition -ApiVersion $ApiVersion
}

function New-VstsReleaseDefinitionStageTask() {
    param (
        [Parameter(Mandatory = $true)] $DefinitionID, # Uint64
        [Parameter(Mandatory = $true)] $StageID, # Uint64
        [Parameter(Mandatory = $true)] $NewTask, # ReleaseEnvironmentDeployPhaseTask
        [Parameter(Mandatory = $false)] $ApiVersion # String
    )

    # Get the entire definition
    $ReleaseDefinition = Get-VstsReleaseDefinition -DefinitionID $DefinitionID -ApiVersion $ApiVersion

    # Get definition stage based on id
    $ReleaseStage = Get-VstsReleaseDefinitionStage -DefinitionID $DefinitionID -StageID $StageID -ApiVersion $ApiVersion

    # Extract tasks array from the stage
    $ReleaseStageTasks = [System.Collections.ArrayList] $ReleaseStage.deployPhases[0].workflowTasks

    # Add the new task from param
    $ReleaseStageTasks.Add($NewTask) | Out-Null

    # Overwrite stage proprierty
    $ReleaseStage.deployPhases[0].workflowTasks = $ReleaseStageTasks

    # Overwrite definition proprierty
    for ($i = 0; $i -lt $ReleaseDefinition.environments.Count; $i++) {
        if ($ReleaseDefinition.environments[$i].id -eq $StageID) {
            $ReleaseDefinition.environments[$i] = $ReleaseStage
            break
        }
    }

    # Update its definition
    $ReleaseDefinition = $ReleaseDefinition | ConvertTo-Json -Depth 50
    Set-VstsReleaseDefinition -DefinitionID $DefinitionID -NewBody $ReleaseDefinition -ApiVersion $ApiVersion
}