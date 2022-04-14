pipeline {
  agent any
  stages {
    stage("verify tooling") {
      steps {
        sh '''
          docker version
          docker info
          docker compose version 
          curl --version
          git version
        '''
      }
    }
    stage('start container') {
      steps {
        sh 'docker compose up -d --no-color --wait'
        sh 'docker compose ps'
      }
    }
    stage("docker image clean up") {
      steps {
        sh 'docker image prune -a -f'
      }
    }
  }
}