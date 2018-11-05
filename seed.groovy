#!/usr/bin/env groovy

pipeline {

agent any

stages {
    stage('Create Jobs'){
          steps {
                jobDsl targets: ['seed.dsl'].join('\n'), removedJobAction: 'DISABLE', sandbox: true
            }
        }
    }
}
