node {
  withEnv(['CI=true', 'REGISTRY=steveystyle/server-app', 'REGISTRY_CREDENTIAL=dockerhub']) {
    APP = null
    B_NO = "${env.BUILD_NUMBER}.0"
    stage('Clone repository') {
      checkout scm
    }
    stage('Test') {
      echo"${env.REGISTRY}:${env.BUILD_NUMBER}.0"
      echo"${env.REGISTRY}:${B_NO}"
    }
    stage('Build image') {
      APP = docker.build("${env.REGISTRY}:${B_NO}")
    }
    stage('Test image') {
      APP.inside {
        sh 'node serrver.js &'
      }
    }
    stage('Push image') {
      docker.withRegistry('', REGISTRY_CREDENTIAL) {
            APP.push("${B_NO}")
            APP.push('latest')
      }
    }
    post {
    success {
      withKubeConfig([credentialsId: 'mykubeconfig']) {
        sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'
        sh 'chmod u+x ./kubectl'
        sh './kubectl set image deployments/server-app server-app='APP''
      }
      //sh 'docker rmi REGISTRY:B_No'
      sh 'docker rmi 'APP''
    }
    failure {
        sh 'docker rmi 'APP''
    }
    }
  }
}
