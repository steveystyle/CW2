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
     stage('Test2') {
       options {
         timeout(time: 30, unit: 'SECONDS')
       }
       steps {         
         script {
           DOCKER_IMAGE.withRun('-d') {c ->
             def IP_STRING = sh(script: "docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' c", returnStdout: true).trim()
             echo IP_STRING
             sh "curl ${IP_STRING}:8080"
             sh "curl ${hostIp(c)}:8080"
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
              try {
                def IP_STRING = sh(script: 'ip addr | grep global', returnStdout: true).trim()
                def IP_STRING_ARR_1 = IP_STRING.split('/')
                def IP_STRING_ARR_2 = IP_STRING_ARR_1[0].split(' ')
                // sh 'node server.js &'
                sh "curl ${IP_STRING_ARR_2[1]}:8080"
              } catch (err) {
                echo "Caught: ${err}"
                currentBuild.result = 'failure'
              }
            }
          } catch (e) {
            echo "Caught: ${e}"
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

