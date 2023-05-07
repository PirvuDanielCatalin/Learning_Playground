Using module $PSScriptRoot\ClassDefinitions\BuildDefinitionClass.psm1
Using module $PSScriptRoot\ClassDefinitions\ReleaseDefinitionClass.psm1

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
##################### New-VstsReleaseDefinitionStage #########################
##############################################################################
$ReleaseEnvironmentDeployPhaseTasks = [System.Collections.ArrayList]::new()

$CommandLineScriptStageTaskInputsScript = 'echo "Cod adaugat din script #1"'
$ReleaseEnvironmentDeployPhaseTaskInputs = [CommandLineScriptStageTaskInputs]::new($CommandLineScriptStageTaskInputsScript)
$ReleaseEnvironmentDeployPhaseTask = [ReleaseEnvironmentDeployPhaseTask]::new(
    "d9bafed4-0b18-4f58-968d-86655b4d2ce9",
    "2.*",
    "Command Line Script",
    $ReleaseEnvironmentDeployPhaseTaskInputs
)

$ReleaseEnvironmentDeployPhaseTasks.Add($ReleaseEnvironmentDeployPhaseTask) | Out-Null
$ReleaseEnvironmentDeployPhaseDeploymentInput = [System.Object] @{
    agentSpecification = [System.Object] @{
        identifier = "vs2017-win2016"
    }
}
$ReleaseEnvironmentDeployPhaseName = "Agent job"

$ReleaseEnvironmentDeployPhase = [ReleaseEnvironmentDeployPhase]::new(
    $ReleaseEnvironmentDeployPhaseDeploymentInput,
    $ReleaseEnvironmentDeployPhaseName,
    $ReleaseEnvironmentDeployPhaseTasks
)

$ReleaseEnvironmentName = "Stage 4"
$ReleaseEnvironmentRank = "4"
$ReleaseEnvironmentPreDeployApprovals = [System.Object] @{
    approvals       = [System.Object] @{
        0 = [System.Object] @{
            rank             = "1"
            isAutomated      = "true"
            isNotificationOn = "false"
        }
    }	
    approvalOptions = [System.Object] @{
        releaseCreatorCanBeApprover                             = "false"
        autoTriggeredAndPreviousEnvironmentApprovedCanBeSkipped = "false"
        enforceIdentityRevalidation                             = "false"
        timeoutInMinutes                                        = "0"
        executionOrder                                          = "beforeGates"
    }
}
$ReleaseEnvironmentPostDeployApprovals = [System.Object] @{
    approvals       = [System.Object] @{
        0 = [System.Object] @{
            rank             = "1"
            isAutomated      = "true"
            isNotificationOn = "false"
        }
    }	
    approvalOptions = [System.Object] @{
        releaseCreatorCanBeApprover                             = "false"
        autoTriggeredAndPreviousEnvironmentApprovedCanBeSkipped = "false"
        enforceIdentityRevalidation                             = "false"
        timeoutInMinutes                                        = "0"
        executionOrder                                          = "afterSuccessfulGates"
    }
}

$ReleaseEnvironmentDeployPhases = [System.Collections.ArrayList]::new()
$ReleaseEnvironmentDeployPhases.Add($ReleaseEnvironmentDeployPhase) | Out-Null
$ReleaseEnvironmentRetentionPolicy = [System.Object] @{
    daysToKeep     = "30"
    releasesToKeep = "3"
    retainBuild    = "true"
}


$NewStage = [ReleaseEnvironment]::new(
    $ReleaseEnvironmentName,
    $ReleaseEnvironmentRank,
    $ReleaseEnvironmentPreDeployApprovals,
    $ReleaseEnvironmentPostDeployApprovals,
    $ReleaseEnvironmentDeployPhases,
    $ReleaseEnvironmentRetentionPolicy
)

New-VstsReleaseDefinitionStage -DefinitionID 1 -NewStage $NewStage -ApiVersion: "5.1"
##############################################################################