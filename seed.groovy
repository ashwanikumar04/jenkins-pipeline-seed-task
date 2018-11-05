#!/usr/bin/env groovy

pipeline {
    agent any

    // parameters {
    //     booleanParam(name: "GO?", defaultValue: true,
    //         description: "Dummy parameter to prevent running the job just by one click only.")
    // }

    stages {
        stage('Create All Jobs') {
            steps {
                jobDsl sandbox: true, removedJobAction: 'DISABLE', targets: """
seed.dsl
"""
            }
        }
    }
}
