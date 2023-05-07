class ReleaseEnvironmentDeployPhaseTaskInputs {
    ReleaseEnvironmentDeployPhaseTaskInputs() { }
}

class CommandLineScriptStageTaskInputs : ReleaseEnvironmentDeployPhaseTaskInputs {
    [string] $script

    CommandLineScriptStageTaskInputs() { }
    CommandLineScriptStageTaskInputs(
        [string] $script
    ) {
        $this.script = $script
    }
}

class ReleaseEnvironmentDeployPhaseTask {
    [string] $taskId
    [string] $version
    [string] $name
    [ReleaseEnvironmentDeployPhaseTaskInputs] $inputs

    ReleaseEnvironmentDeployPhaseTask() { }
    ReleaseEnvironmentDeployPhaseTask(
        [string] $taskId,
        [string] $version,
        [string] $name,
        [ReleaseEnvironmentDeployPhaseTaskInputs] $inputs
    ) {
        $this.taskId = $taskId
        $this.version = $version
        $this.name = $name
        $this.inputs = $inputs
    }
}

class ReleaseEnvironmentDeployPhase {
    [System.Object] $deploymentInput
    [string] $name
    [System.Collections.ArrayList] $workflowTasks

    ReleaseEnvironmentDeployPhase() { }
    ReleaseEnvironmentDeployPhase(
        [System.Object] $deploymentInput,
        [string] $name,
        [System.Collections.ArrayList] $workflowTasks
    ) {
        $this.deploymentInput = $deploymentInput
        $this.name = $name
        $this.workflowTasks = $workflowTasks
    }

    AddTask([ReleaseEnvironmentDeployPhaseTask] $NewTask) {
        $this.workflowTasks.Add($NewTask) | Out-Null
    }
}

class ReleaseEnvironment {
    [string] $name
    [uint64] $rank
    [System.Object] $preDeployApprovals
    [System.Object] $postDeployApprovals
    [System.Collections.ArrayList] $deployPhases
    [System.Object] $retentionPolicy

    ReleaseEnvironment() { }
    ReleaseEnvironment(
        [string] $name,
        [uint64] $rank,
        [System.Object] $preDeployApprovals,
        [System.Object] $postDeployApprovals,
        [System.Collections.ArrayList] $deployPhases,
        [System.Object] $retentionPolicy
    ) {
        $this.name = $name
        $this.rank = $rank
        $this.preDeployApprovals = $preDeployApprovals
        $this.postDeployApprovals = $postDeployApprovals
        $this.deployPhases = $deployPhases
        $this.retentionPolicy = $retentionPolicy
    }
}

class ReleaseDefinition {
    [System.Collections.ArrayList] $environments
    [System.Collections.ArrayList] $artifacts
    [string] $name

    ReleaseDefinition() { }
    ReleaseDefinition(
        [System.Collections.ArrayList] $environments,
        [System.Collections.ArrayList] $artifacts,
        [string] $name
    ) {
        $this.environments = $environments
        $this.artifacts = $artifacts
        $this.name = $name
    }

    AddStage([ReleaseEnvironment] $NewStage) {
        $this.environments.Add($NewStage) | Out-Null
    }
}