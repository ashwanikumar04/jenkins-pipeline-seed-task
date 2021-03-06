#!/usr/bin/env groovy

def builds2Keep = 5        // number of builds to keep
def num2Keep = 5            // number of artifacts to keep
def delaySeconds = 30      // number of seconds to delay build start after a commit

pipelineJob("scripted-pipeline-job") {
    keepDependencies(false)
    quietPeriod(delaySeconds)
    //triggers { cron('H 0 * * *') }
    logRotator { numToKeep(builds2Keep); artifactNumToKeep(num2Keep) }

    definition {
        cpsScm {
            lightweight(true)
            scm {
                git {
                    remote {
                        github("ashwanikumar04/jenkins-pipeline")
                    }
                    branches('*/master')
                }
            }
        }
    }
}

pipelineJob("scripted-pipeline-job1") {
    keepDependencies(false)
    quietPeriod(delaySeconds)
    //triggers { cron('H 0 * * *') }
    logRotator { numToKeep(builds2Keep); artifactNumToKeep(num2Keep) }

    definition {
        cpsScm {
            lightweight(true)
            scm {
                git {
                    remote {
                        github("ashwanikumar04/jenkins-pipeline")
                    }
                    branches('*/master')
                }
            }
        }
    }
}

multibranchPipelineJob("scripted-multi-pipeline-job-new2") {
    branchSources {
        github {
            repoOwner('ashwanikumar04')
            repository('jenkins-pipeline')
            includes('develop release/* feature/*')
        }
    }

    orphanedItemStrategy {
        discardOldItems {
            numToKeep(10)
            daysToKeep(10)
        }
    }

    configure { project ->
        project / 'sources' / 'data' / 'jenkins.branch.BranchSource'/ strategy(class: 'jenkins.branch.DefaultBranchPropertyStrategy') {
            properties(class: 'java.util.Arrays$ArrayList') {
                a(class: 'jenkins.branch.BranchProperty-array'){
                'jenkins.branch.NoTriggerBranchProperty'()
                }
            }
        }
    }

    triggers {
        periodic(24*60)
    }
  }