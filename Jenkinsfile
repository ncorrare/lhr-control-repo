ruby = '2.1.9'
pipeline {
  agent any
  stages { 
    stage('Prep Environment') {
      steps {
        withRvm {
          sh 'which bundle || gem install bundler'
          sh 'bundle install'
        }
      }
    }
    stage('Parsing Checks') {
      steps {
          rake 'validate'
        
      }
    }
    stage('Linting Checks') {
      steps {
          rake 'lint'
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

def withRvm(Closure stage) {
  rubyVersion = "ruby-$ruby"
  RVM_HOME = '.rvm'

  paths = [
      "$RVM_HOME/gems/$rubyVersion@global/bin",
      "$RVM_HOME/rubies/$rubyVersion/bin",
      "$RVM_HOME/bin",
      "${env.PATH}"
  ]

  env.PATH = paths.join(':')
  env.GEM_PATH = "$RVM_HOME/gems/$rubyVersion@global"
  env.MY_RUBY_HOME = "$RVM_HOME/rubies/$rubyVersion"
  env.IRBRC = "$RVM_HOME/rubies/$rubyVersion/.irbrc"
  env.RUBY_VERSION = "$rubyVersion"
  sh """curl -sSL https://get.rvm.io | bash -s stable
  /.rvm/scripts/rvm
  rvm use $ruby"""

  stage()
}

// Helper function for rake
def rake(String command) {
  sh "bundle exec rake $command"
}

// Exception helper
def handleException(Exception err) {
  println(err.toString());
  println(err.getMessage());
  println(err.getStackTrace());

  throw err
}
