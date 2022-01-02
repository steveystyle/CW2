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
      echo 'InetAddress.localHost.hostAddress'
    }
    stage('Build image') {
      APP = docker.build("${env.REGISTRY}:${B_NO}")
    }
    stage('Test image') {
      APP.inside('-it') {
        try {
          echo 'hello'
          // sh 'node server.js &'
        } catch (err) {
          echo "Caught: ${err}"
          currentBuild.result = 'FAILURE'
        }
      }
    }
    stage('Test withrun') {
      APP.withRun('--rm -it') {
        echo 'hello2'
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
