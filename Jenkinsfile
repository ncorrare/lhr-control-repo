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
        apt-get install --yes --force-yes g++
        curl -sSL https://get.rvm.io | bash -s stable
        source /etc/profile.d/rvm.sh
        rvm install ruby-2.1.9
        rvm use 2.1.9
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
