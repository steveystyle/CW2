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
              def ipStringArr1 = ipString.split('/')
              echo "${ipStringArr1[0]}"
              def ipStringArr2 = ipStringArr1[0].split(' ')
              echo "${ipStringArr2[1]}"
              sh 'node server.js &'
              sh "curl ${ipStringArr2[1]}:8080"
            } catch (err) {
              echo "Caught: ${err}"
              currentBuild.result = 'failure'
            }
          }
        }
      }
    }
  }
  post {
    success {
      withKubeConfig([credentialsId: 'mykubeconfig']) {
        sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'
        sh 'chmod u+x ./kubectl'
        sh "./kubectl set image deployments/server-app server-app=${env.dockerImage}"
      }
      sh "docker rmi dockerImage"
    }
    failure {
      sh "docker rmi dockerImage"
    }
  }
}

