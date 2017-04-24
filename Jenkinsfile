pipeline {
  agent any
  stages { 
    stage('Prep Environment') {
      steps {
        sh '''#!/bin/bash
        source /etc/profile.d/rvm.sh
        bundle install --path=.bundle/gems/
        '''
      }
    }
    stage('Parsing Checks') {
      steps {
          sh 'source /etc/profile.d/rvm.sh'
          sh 'rake validate'
        
      }
    }
    stage('Linting Checks') {
      steps {
          sh 'source /etc/profile.d/rvm.sh'
          sh 'rake lint'
      }
    }
    stage('Deploy') {
      steps {
        echo 'done'
        }
        
    }
  }
  environment {
    puppetmaster = 'puppet.service.lhr.consul'
  }
}
