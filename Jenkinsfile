node {
  withEnv(['CI=true', 'REGISTRY=steveystyle/server-app', 'REGISTRY_CREDENTIAL=dockerhub']) {
    APP = null
    B_NO = "${env.BUILD_NUMBER}.0"
    stage('Clone repository') {
      checkout scm
    }
    stage('Build image') {
      APP = docker.build("${env.REGISTRY}:${B_NO}")
    }
    stage('Test Image') {
      APP.inside {
        try {
          ANS = sh script: 'node serrver.js &', returnStatus: true
          ANS2 = sh script: 'node server.js &', returnStatus: true
        echo"${ANS}"
        echo"${ANS2}"
        } catch (err) {
          echo "Caught: ${err}"
          currentBuild.result = 'FAILURE'
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
