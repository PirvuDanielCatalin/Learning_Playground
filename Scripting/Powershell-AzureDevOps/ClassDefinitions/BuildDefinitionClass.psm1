
class BuildProcessPhaseStepTask {
    [string] $id
    [string] $versionSpec
    [string] $definitionType

    BuildProcessPhaseStepTask() { }
    BuildProcessPhaseStepTask(
        [string] $id,
        [string] $versionSpec,
        [string] $definitionType
    ) {
        $this.id = $id
        $this.versionSpec = $versionSpec
        $this.definitionType = $definitionType
    }
}

class BuildProcessPhaseStepInputs {
    BuildProcessPhaseStepInputs() { }
}

class DockerInputs : BuildProcessPhaseStepInputs {
    [string] $containerregistrytype
    [string] $azureSubscriptionEndpoint
    [string] $azureContainerRegistry
    [string] $action
    [string] $dockerFile

    DockerInputs() { }
    DockerInputs(
        [string] $containerregistrytype,
        [string] $azureSubscriptionEndpoint,
        [string] $azureContainerRegistry,
        [string] $action,
        [string] $dockerFile
    ) {
        $this.containerregistrytype = $containerregistrytype
        $this.azureSubscriptionEndpoint = $azureSubscriptionEndpoint
        $this.azureContainerRegistry = $azureContainerRegistry
        $this.action = $action
        $this.dockerFile = $dockerFile
    }
}

class CommandLineScriptInputs : BuildProcessPhaseStepInputs {
    [string] $script
    
    CommandLineScriptInputs() { }
    CommandLineScriptInputs(
        [string] $script
    ) {
        $this.script = $script
    }
}

class BuildProcessPhaseStep {
    [string] $displayName
    [BuildProcessPhaseStepTask] $task
    [BuildProcessPhaseStepInputs] $inputs

    BuildProcessPhaseStep() { }
    BuildProcessPhaseStep(
        [string] $displayName,
        [BuildProcessPhaseStepTask] $task,
        [BuildProcessPhaseStepInputs] $inputs
    ) {
        $this.displayName = $displayName
        $this.task = $task
        $this.inputs = $inputs
    }
}

class BuildProcessPhase {
    [System.Collections.ArrayList] $steps
    [string] $name

    BuildProcessPhase() { }
    BuildProcessPhase(
        [System.Collections.ArrayList] $steps,
        [string] $name
    ) {
        $this.steps = $steps
        $this.name = $name
    }
    BuildProcessPhase([System.Object] $BuildProcessPhase) {
        $this.steps = [System.Collections.ArrayList] $BuildProcessPhase.steps
        $this.name = [string] $BuildProcessPhase.name
    }

    AddPhaseStep($NewStep) {
        $this.steps.Add($NewStep);
    }
}

class BuildProcess {
    [System.Collections.ArrayList] $phases
    [System.Object] $target
    [int] $type

    BuildProcess() { }
    BuildProcess(
        [System.Collections.ArrayList] $phases, 
        [System.Object] $target, 
        [int] $type
    ) {
        $this.phases = $phases
        $this.target = $target
        $this.type = $type
    }
}

class BuildRepositoryProperties {
    BuildRepositoryProperties() { }
}

class BuildRepository {
    # [BuildRepositoryProperties] $properties
    [string] $type
    [string] $name
    [string] $defaultBranch

    BuildRepository() { }
    BuildRepository(
        [string] $type,
        [string] $name,
        [string] $defaultBranch
    ) {
        $this.type = $type
        $this.name = $name
        $this.defaultBranch = $defaultBranch
    }
}

class BuildQueue {
    BuildQueue() { }
}

class BuildDefinition {
    [BuildProcess] $process
    [BuildRepository] $repository
    [System.Object] $queue
    [string] $name
    [string] $type
    [string] $queueStatus

    BuildDefinition() { }

    BuildDefinition(
        [BuildProcess] $process,
        [BuildRepository] $repository,
        [System.Object] $queue,
        [string] $name,
        [string] $type,
        [string] $queueStatus
    ) {
        $this.process = $process
        $this.repository = $repository
        $this.queue = $queue
        $this.name = $name
        $this.type = $type
        $this.queueStatus = $queueStatus
    }
}