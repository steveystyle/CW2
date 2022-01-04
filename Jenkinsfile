pipeline {
  environment {
    REGISTRY = 'steveystyle/server-app'
    REGISTRY_CREDENTIALS = 'dockerhub'
    DOCKER_IMAGE = ''
    B_NO = "${BUILD_NUMBER}.0"
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
          DOCKER_IMAGE = docker.build "${env.REGISTRY}:${env.B_NO}"
        }
      }
    }

    stage('Push Image') {
      steps {
        script {
          docker.withRegistry('', env.REGISTRY_CREDENTIALS) {
            DOCKER_IMAGE.push("${env.B_NO}")
            DOCKER_IMAGE.push('latest')
          }
        }
      }
    }    
   
    stage('Build Test') {
      steps {
        script {
          try {
            DOCKER_IMAGE.inside {
              if (!fileExists('server.js')) {
                currentBuild.result = 'failure'
                error('Server.js file missing Image Build fail')
              } 
            }   
          } catch (e) {
              echo "Caught: ${e}"
              currentBuild.result = 'failure'
          }
        }
      }    
    } 
      
    stage('Run Test') {
      options {
        timeout(time: 30, unit: 'SECONDS')
      }
      steps {
        script {
          try {
            DOCKER_IMAGE.withRun('--name test --network minikube') {c ->
              def IP_STRING = sh(script: "docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' c", returnStdout: true).trim()
              echo IP_STRING
              sh "curl -v ${IP_STRING}:8080"
            }
          } catch (err) {
              echo "Caught: ${err}"
              currentBuild.result = 'failure'
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
        sh "./kubectl set image deployments/server-app server-app=${env.REGISTRY}:${env.B_NO}"
      }
      sh 'docker system prune -a -f --volumes'
    }
    failure {
      sh 'docker system prune -a -f --volumes'
    }
  }
}
