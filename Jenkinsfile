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
      environment {
          SECRET = credentials('c-sample-secret')
      }
      steps {
        sh "echo \$SECRET >> .env"
        sh "ls -a"
        sh "cat .env"
        sh 'docker compose up --build -d --no-color --wait'
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