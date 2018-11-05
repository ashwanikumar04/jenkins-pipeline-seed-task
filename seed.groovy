#!/usr/bin/env groovy

pipeline {

agent any

stages {
    stage{
         jobDsl targets: ['seed.dsl'].join('\n'),
           removedJobAction: 'DELETE',
           removedViewAction: 'DELETE'

    }
}
}