Using module .\BuildDefinitionClass.psm1

Import-Module $PSScriptRoot\Classes\Library.psm1

##############################################################################
##################### Token & Organization & Project #########################
##############################################################################
Set-AuthenticationHeader
Set-Organization
Set-Project
Set-ApiVersion -ApiVersion: "5.1"
##############################################################################


##############################################################################
########################## Get-VstsGitRepositories ###########################
##############################################################################
$GitRepositories = Get-VstsGitRepositories
# $GitRepositories | Out-GridView   # For PowerShell console outside VS Code
$GitRepositories                    # For PowerShell console inside VS Code
##############################################################################


##############################################################################
######################### Get-VstsBuildDefinition ############################
##############################################################################
$BuildDefinitions = Get-VstsBuildDefinition
# $BuildDefinitions | Out-GridView  # For PowerShell console outside VS Code
$BuildDefinitions                   # For PowerShell console inside VS Code
##############################################################################


##############################################################################
######################### Set-VstsBuildDefinition ############################
##############################################################################
$BuildDefinition = Get-VstsBuildDefinition -DefinitionID 4
$BuildProcessPhase = [BuildProcessPhase]::new($BuildDefinition.process.phases[0])

# Step {
$BuildProcessPhaseStepDisplayName = "Command Line Script"
$BuildProcessPhaseStepTask = [BuildProcessPhaseStepTask]::new(
    "d9bafed4-0b18-4f58-968d-86655b4d2ce9", 
    "2.*", 
    "task"
)
$BuildProcessPhaseStepInputs = [CommandLineScriptInputs]::new(
    'echo "Pas nou adaugat din script"'
)
$BuildProcessPhaseStep = [BuildProcessPhaseStep]::new($BuildProcessPhaseStepDisplayName, $BuildProcessPhaseStepTask, $BuildProcessPhaseStepInputs)
# } Step

$BuildProcessPhase.AddPhaseStep($BuildProcessPhaseStep)
$BuildDefinition.process.phases[0] = $BuildProcessPhase

$BuildDefinition = $BuildDefinition | ConvertTo-Json -Depth 50

Set-VstsBuildDefinition -DefinitionID 4 -NewBody $BuildDefinition
##############################################################################


##############################################################################
######################### New-VstsBuildDefinition ############################
##############################################################################
# Body {
# Process {
$BuildProcessPhases = [System.Collections.ArrayList]::new()
$BuildProcessPhaseSteps = [System.Collections.ArrayList]::new()
    
# Phase {
# Step {
$BuildProcessPhaseStepDisplayName = "Build an image"
$BuildProcessPhaseStepTask = [BuildProcessPhaseStepTask]::new(
    "e28912f1-0114-4464-802a-a3a35437fd16", 
    "0.*", 
    "task"
)
$azureContainerRegistry = @{
    loginServer = "sprint2projectcr.azurecr.io"
    id          = "/subscriptions/d7ca6294-4acf-419b-a566-62755baf9431/resourceGroups/Sprint2Project/providers/Microsoft.ContainerRegistry/registries/Sprint2ProjectCR"
}
$BuildProcessPhaseStepInputs = [DockerInputs]::new(
    "Azure Container Registry", 
    "cee82b34-2da1-4a79-b9fa-9b802d343455", 
    ($azureContainerRegistry | ConvertTo-Json), 
    "Build an image",
    "**/Dockerfile"
)
$BuildProcessPhaseStep = [BuildProcessPhaseStep]::new($BuildProcessPhaseStepDisplayName, $BuildProcessPhaseStepTask, $BuildProcessPhaseStepInputs)
$BuildProcessPhaseSteps.Add($BuildProcessPhaseStep) | Out-Null
# } Step
    
# Step {
$BuildProcessPhaseStepDisplayName = "Push an image"
$BuildProcessPhaseStepTask = [BuildProcessPhaseStepTask]::new(
    "e28912f1-0114-4464-802a-a3a35437fd16", 
    "0.*", 
    "task"
)
$azureContainerRegistry = @{
    loginServer = "sprint2projectcr.azurecr.io"
    id          = "/subscriptions/d7ca6294-4acf-419b-a566-62755baf9431/resourceGroups/Sprint2Project/providers/Microsoft.ContainerRegistry/registries/Sprint2ProjectCR"
}
$BuildProcessPhaseStepInputs = [DockerInputs]::new(
    "Azure Container Registry", 
    "cee82b34-2da1-4a79-b9fa-9b802d343455", 
    ($azureContainerRegistry | ConvertTo-Json), 
    "Push an image",
    "**/Dockerfile"
)
$BuildProcessPhaseStep = [BuildProcessPhaseStep]::new($BuildProcessPhaseStepDisplayName, $BuildProcessPhaseStepTask, $BuildProcessPhaseStepInputs)
$BuildProcessPhaseSteps.Add($BuildProcessPhaseStep) | Out-Null
# } Step
    
$BuildProcessPhaseName = "Agent Job"
$BuildProcessPhase = [BuildProcessPhase]::new($BuildProcessPhaseSteps, $BuildProcessPhaseName)
$BuildProcessPhases.Add($BuildProcessPhase) | Out-Null
# } Phase
    
$BuildProcessTarget = [System.Object] @{
    agentSpecification = [System.Object] @{
        identifier = "ubuntu-16.04"
    }
}
$BuildProcessType = 1
$BuildProcess = [BuildProcess]::new($BuildProcessPhases, $BuildProcessTarget, $BuildProcessType)
# } Process
    
# BuildRepository { 
$BuildRepositoryType = "TfsGit"
$BuildRepositoryName = "sprint2_httpd_horse"
$BuildRepositoryDefaultBranch = "refs/heads/master"
$BuildRepository = [BuildRepository]::new($BuildRepositoryType, $BuildRepositoryName, $BuildRepositoryDefaultBranch)
# } BuildRepository
    
$BuildQueue = [System.Object] @{
    name = "Azure Pipelines"
    pool = [System.Object] @{
        name     = "Azure Pipelines"
        isHosted = "true"
    }
}
$BuildName = "DevOps_WinProject-Build-Nou"
$BuildType = "build"
$BuildQueueStatus = "enabled"
$BuildDefinition = [BuildDefinition]::new($BuildProcess, $BuildRepository, $BuildQueue, $BuildName, $BuildType, $BuildQueueStatus)
# } Body
    
$BuildDefinition = $BuildDefinition | ConvertTo-Json -Depth 50
New-VstsBuildDefinition -Body $BuildDefinition
##############################################################################


##############################################################################
######################## Get-VstsReleaseDefinition ###########################
##############################################################################
$ReleaseDefinitions = Get-VstsReleaseDefinition
# $ReleaseDefinition | Out-GridView     # For PowerShell console outside VS Code
$ReleaseDefinitions                     # For PowerShell console inside VS Code
##############################################################################


##############################################################################
##################### Get-VstsReleaseDefinitionStage #########################
##############################################################################
$ReleaseDefinitions = Get-VstsReleaseDefinitionStage -DefinitionID "1" -StageName "Stage 1"
# $ReleaseDefinition | Out-GridView     # For PowerShell console outside VS Code
$ReleaseDefinitions                     # For PowerShell console inside VS Code
##############################################################################


##############################################################################
############################ Queue-BuildPipeline #############################
##############################################################################
$BuildDefinitions = Queue-BuildPipeline -DefinitionID "4"
# $ReleaseDefinition | Out-GridView     # For PowerShell console outside VS Code
$BuildDefinitions                       # For PowerShell console inside VS Code
##############################################################################