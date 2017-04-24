rubyVersion = '2.1.9'
pipeline {
  agent any
  stages { 
    stage('Prep Environment') {
      steps {
        sh """#!/bin/bash
        curl -sSL https://get.rvm.io | bash -s stable
        source /.rvm/scripts/rvm
        rvm install ruby-$rubyVersion
        rvm use $rubyVersion
        which bundle || gem install bundler
        bundle install"""
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
    PATH="/bin:/usr/bin:/sbin:/usr/sbin:/.rvm/gems/ruby-$rubyVersion@global/bin:/.rvm/rubies/ruby-$rubyVersion/bin:/.rvm/bin"
  }
}

// Exception helper
def handleException(Exception err) {
  println(err.toString());
  println(err.getMessage());
  println(err.getStackTrace());

  throw err
}
