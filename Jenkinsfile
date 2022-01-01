pipeline{  
  environment{
    registry = "steveystyle/server-app"
    registryCredential = 'dockerhub'
    dockerImage = ''
    bNO = "$BUILD_NUMBER" + ".0"
    CI = 'true'
  }
  
  agent any
  
  stages{
    
    stage('Clone Git'){ 
      steps{
        git branch: 'main', credentialsId: 'GitHub', url: 'https://github.com/steveystyle/cw2.git'
      }
    }
    
    stage('Build Image'){
      steps{
        script{
          dockerImage = docker.build registry + ":$bNo"
        }
      }
    }
    
    stage('Push Image'){
      steps{
        script{
          docker.withRegistry( '', registryCredential ){
            dockerImage.push()
          }
        }  
      }
    }
    
    stage('Build Test') {
      steps{
        script{
          dockerImage.inside{          
            sh 'node server.js &'
          }
        }
      }
    }
  }
  
  post{ 
    success{
      withkubeConfig([credentialsId: 'mykubeconfig']) {
        sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'
        sh 'chmod u+x ./kubectl'
        sh './kubectl get pods'
      }
      sh "docker rmi $registry:$bNo" 
    }
    failure{
        sh "docker rmi $registry:$bNo"      
    }
  }
}
