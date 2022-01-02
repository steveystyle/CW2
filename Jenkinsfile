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
        try {
          sh 'node serrver.js &; exit 1'
        } catch (err) {
          echo "Caught: ${err}"
          currentBuild.result = 'FAILURE'
          echo"blah${currentBuild.result}"
        }
      }
    }
    stage('Push image') {
      docker.withRegistry('', REGISTRY_CREDENTIAL) {
            APP.push("${B_NO}")
            APP.push('latest')
      }
    }
  }
}
