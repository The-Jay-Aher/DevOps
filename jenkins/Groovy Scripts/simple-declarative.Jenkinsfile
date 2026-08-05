pipeline {
  agent any
  
  triggers{
    cron('0 3 * * 1-5')
  }
  
  stages {
    stage('SCM') {
      git branch: 'main', url: 'https://github.com/FeynmanFan/declarativepipeline.git'
    }
  }
}