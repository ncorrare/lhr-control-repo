pipeline {
  agent {
    node {
      label 'nomad'
    }
    
  }
  stages {
    stage('Prep Environment') {
      steps {
        sh '''#!/bin/bash
        source /etc/profile.d/rvm.sh
        rvm use 2.1.9
        which rake || gem install rake
        which bundle || gem install bundler
        bundle install'''
      }
    }
    stage('Parsing Checks') {
      steps {
        sh 'rake validate'
      }
    }
    stage('Linting Checks') {
      steps {
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
    PATH="/bin:/usr/bin:/sbin:/usr/sbin:/.rvm/gems/ruby-2.1.9@global/bin:/.rvm/rubies/ruby-2.1.9/bin:/.rvm/bin"
  }
}
