pipeline {
  environment {
    registry = 'steveystyle/server-app'
    registryCredential = 'dockerhub'
    dockerImage = ''
    result = ''
    bNO = "${BUILD_NUMBER}.0"
    CI = 'true'
  }
  agent any
  stages {

    stage('Clone Git') {
      steps {
        git branch: 'main', credentialsId: 'GitHub', url: 'https://github.com/steveystyle/cw2.git'
      }
    }

    stage('Build Image') {
      steps {
        script {
          dockerImage = docker.build "${env.registry}:${env.bNo}"
        }
      }
    }

    stage('Push Image') {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            dockerImage.push()
          }
        }
      }
    }

    stage('Build Test') {
      steps {
        script {
          dockerImage.inside {
            try {
              // ans3 = fileExists file: 'serrver.js'
              sh 'ip addr | grep global'
              sh 'node server.js &'
              sh 'curl 172.17.0.2:8080'
            } catch (err) {
              echo "Caught: ${err}"
              currentBuild.result = 'failure'
            }
          }
        } 
      }
    }
  }
}
