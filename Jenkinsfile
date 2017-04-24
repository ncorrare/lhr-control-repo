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

def withRvm(version, gemset, cl) {
    RVM_HOME='$HOME/.rvm'
    paths = [
        "$RVM_HOME/gems/$version@$gemset/bin",
        "$RVM_HOME/gems/$version@global/bin",
        "$RVM_HOME/rubies/$version/bin",
        "$RVM_HOME/bin",
        "${env.PATH}"
    ]
    def path = paths.join(':')
    withEnv(["PATH=${env.PATH}:$RVM_HOME", "RVM_HOME=$RVM_HOME"]) {
        sh "set +x; source $RVM_HOME/scripts/rvm; rvm use --create --install --binary $version@$gemset"
    }
    withEnv([
        "PATH=$path",
        "GEM_HOME=$RVM_HOME/gems/$version@$gemset",
        "GEM_PATH=$RVM_HOME/gems/$version@$gemset:$RVM_HOME/gems/$version@global",
        "MY_RUBY_HOME=$RVM_HOME/rubies/$version",
        "IRBRC=$RVM_HOME/rubies/$version/.irbrc",
        "RUBY_VERSION=$version"
        ]) {
            sh 'gem install bundler'
            cl()
        }
    }
