pipeline {
  environment {
    registry = 'steveystyle/server-app'
    registryCredential = 'dockerhub'
    dockerImage = ''
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
          docker.withRegistry('', env.registryCredential) {
            dockerImage.push("${env.bNo}")
            dockerImage.push('latest')
          }
        }
      }
    }

    stage('Build Test') {
      steps {
        script {
          dockerImage.inside {
            try {
              def ipString = sh(script: 'ip addr | grep global', returnStdout: true).trim()
              echo "${ipString}"
              def ipStringArr = ipString.split('/', 1)
              echo "${ipStringArr[0]}"
              //sh 'node server.js &'
              //sh "${ipStrirg}:8080"
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
