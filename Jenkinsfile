pipeline {
  agent any
  stages { 
    stage('Parsing Checks') {
      steps {
        withRvm('ruby-2.1.9') {
          sh 'bundle install'
          sh 'rake validate'
        }
        
      }
    }
    stage('Linting Checks') {
      steps {
        withRvm('ruby-2.1.9') {
          sh 'rake lint'
        }
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
