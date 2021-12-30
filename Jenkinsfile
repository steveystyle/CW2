pipeline{  
  environment{
    registry = "steveystyle/server_app"
    registryCredential = 'dockerhub'
    dockerImage = ''
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
          dockerImage = docker.build registry + ":$BUILD_NUMBER.0" 
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
    
    stage('Clean'){      
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}
