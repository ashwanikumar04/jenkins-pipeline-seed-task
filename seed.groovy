#!/usr/bin/env groovy

pipeline {

agent any

stages {
    stage('Create Jobs'){
          steps {
                jobDsl targets: ['seed.dsl'].join('\n'), removedJobAction: 'DISABLE'
            }
        }
    }
}

pipeline {
    agent { label 'linux' }

    parameters {
        booleanParam(name: "GO?", defaultValue: true,
            description: "Dummy parameter to prevent running the job just by one click only.")
    }

    stages {
        // NOTE for all 'jobDsl' call:
        //   We MUST combine all scripts in one call in order for the "removedJobAction: 'DISABLE'"
        //   parameter; otherwise latter running dsl calls will disable the jobs created by earlier acctions.
        stage('Create All Jobs') {
            steps {
                jobDsl sandbox: true, removedJobAction: 'DISABLE', targets: """
seed.dsl
"""
            }
        }
    }
}
